if exists (select * from sysobjects where name = 'se_get_nav_account_tree')
begin
	drop procedure se_get_nav_account_tree
	print 'PROCEDURE: se_get_nav_account_tree dropped'
end
go


create procedure [dbo].[se_get_nav_account_tree]
--exec se_get_nav_account_tree @account_id=168,@intraday_code_id=4,@snapshot_date_in='2018-04-05 00:00:00',@control_type=-1
(	
    @account_id varchar(40),
	@intraday_code_id		numeric(10)= 4 ,
	@snapshot_date_in		datetime = '08/04/2017 00:00:00.000',
	@control_type			int = -1,
	@user_or_workgroup		tinyint = 1
) 
as
	declare @model_id numeric(10);
	declare @model_type tinyint;
	declare @hierarchy_id numeric(10)
	declare @hierarchy_sector_id numeric(10)
	declare @ID numeric(10);
	Declare @CoreModel_target float
	Declare @parent_short_name  varchar(40)
	declare @count numeric(10) = 0
	declare @current_user			int = 21
	declare @specific_control_type int;
	declare @date_type int = 0
	
begin

   create table #parent_accounts (account_id numeric(10) not null,short_name varchar(40));
   create table #child_accounts (account_id numeric(10) not null,account_id1 numeric(10) not null,parent_account_id numeric(10) not null,parent_id numeric(10) not null,Parent_short_name varchar(40), Child_short_name varchar(40));
 create table #status_getnavaccttree  	(  		status_calculated			bit		not null,  		focus_on_ok					tinyint	null,  		account_id					numeric(10)	not null,  		account_level_code			tinyint		not null,  		nav_date					datetime	null,  		asof_time					datetime2 null,  		current_dq_status			numeric(10)	null,  		current_result_status		numeric(10)	null,  		current_process_status		numeric(10)	null,  		cmpl_invocation_id			numeric(10)	null  	);

 insert into #parent_accounts  
		  select
			        account.account_id,
					short_name
					from account_hierarchy_map
					join account on account_hierarchy_map.child_id = account.account_id
					where account_hierarchy_map.parent_id = @account_id 
						and account_hierarchy_map.child_type= 2
						and account.deleted = 0
						and account.ad_hoc_flag = 0
						and account.account_id <> @account_id

--select * from #parent_accounts




---- give sub models unique ids-------------------------------
select @ID = min(#parent_accounts.account_id)    
		from #parent_accounts
		declare @a numeric(10) = 0
while @ID is not null   
	begin  

	select @parent_short_name = #parent_accounts.short_name from #parent_accounts where #parent_accounts.account_id = @id
	select @count = @count +1;

 insert into #child_accounts  
		  select
			        account.account_id,
					@a,
					@id,
					@a,
					@parent_short_name,
					short_name
					from account_hierarchy_map
					join account on account_hierarchy_map.child_id = account.account_id
					where account_hierarchy_map.parent_id = @id 
						and account_hierarchy_map.child_type = 3
						and account.deleted = 0
						and account.ad_hoc_flag = 0;

						select @a = @a +1
						
 select 
	@ID = min(#parent_accounts.account_id)    
from #parent_accounts   
where #parent_accounts.account_id >@ID 

end  

---- give sub models unique ids-------------------------------
 

--Get account status

    if @snapshot_date_in is null
	begin
		select @snapshot_date_in = getdate();
	end else begin
		select @snapshot_date_in = @snapshot_date_in;
	end;
	if @control_type = 0 or @control_type = -1
	begin
		select @specific_control_type = null;
	end else begin
		select @specific_control_type = @control_type;
	end;
	insert into #status_getnavaccttree
	(
		account_id,
		account_level_code,
		nav_date,
		asof_time,
		cmpl_invocation_id,
		focus_on_ok,
		status_calculated,
		current_dq_status,		
		current_result_status,		
		current_process_status
	)
	select 
		account.account_id,
		account.account_level_code,
		convert(datetime, convert(nvarchar(10), account_audit.asof_time, 112), 112) as nav_date,
		account_audit.asof_time as asof_time,
		case 
			when @specific_control_type is null 
				then (select MAX(nav_account_process_local.latest_cmpl_invocation_id) 
					from nav_account_process nav_account_process_local
					where datepart(mi,nav_account_process_local.asof_time) = loadhist_definition.asof_minute 
					and	datepart(hh,nav_account_process_local.asof_time) = loadhist_definition.asof_hour
					and datepart(ss,nav_account_process_local.asof_time) = 0 
					and datepart(millisecond,nav_account_process_local.asof_time) = 0
					and 
					(
						(@date_type = 1
						and account_audit.asof_time is not null 
						and nav_account_process_local.asof_time = account_audit.asof_time) 
						or (
							(@date_type = 0)
							 and convert(datetime, convert(nvarchar(10), nav_account_process_local.asof_time, 112), 112) = convert(datetime, convert(nvarchar(10), @snapshot_date_in, 112), 112))
					)
					and nav_account_process_local.account_id = nav_control_activation.account_id 
					and nav_account_process_local.deleted = 0)
			else nav_account_process.latest_cmpl_invocation_id end
			as cmpl_invocation_id,
		case
			when nav_account_process.latest_cmpl_invocation_id is null
				then 0
			else (select distinct 1 
				 from nav_account_process nav_account_process_local
				 join nav_control_type 
					on nav_account_process_local.nav_control_type_code = nav_control_type.nav_control_type_code
				 where nav_account_process_local.account_id = account.account_id and 
				 nav_account_process_local.nav_process_status_code = 6)
			end 
			as focus_on_ok,
		case 
			when @specific_control_type is null and nav_control_activation.nav_control_activation_id is not null
			then 0 else 1 end 
			as status_calculated,
		nav_account_process.calc_worst_data_qlty_status
			as current_dq_status,
		nav_account_process.calc_worst_rule_status
			as current_result_status,
		case 
			when nav_control_activation.nav_control_activation_id is null
				then 2
			else nav_account_process.nav_process_status_code 
			end as current_process_status
	from user_access_map 
	join account 
		on user_access_map.object_id = account.account_id
		and account.deleted = 0
	left outer join nav_control_activation
		on nav_control_activation.account_id = account.account_id
		and nav_control_activation.deleted = 0
		and nav_control_activation.acct_loadhist_definition_id = @intraday_code_id
	left outer join loadhist_definition 
		on nav_control_activation.acct_loadhist_definition_id = loadhist_definition.loadhist_definition_id
		and loadhist_definition.deleted = 0
		and loadhist_definition_type_code = 1
	left outer join account_audit
		on account_audit.account_id = nav_control_activation.account_id
		and datepart(mi,account_audit.asof_time) = loadhist_definition.asof_minute 
		and	datepart(hh,account_audit.asof_time) = loadhist_definition.asof_hour
		and datepart(ss,account_audit.asof_time) = 0 
		and datepart(millisecond,account_audit.asof_time) = 0
		and ((@date_type = 0 and convert(datetime, convert(nvarchar(10), account_audit.asof_time, 112), 112) = convert(datetime, convert(nvarchar(10), @snapshot_date_in, 112), 112) ) or
		     (@date_type = 1 and convert(datetime, convert(nvarchar(10), account_audit.modified_time, 112), 112) = convert(datetime, convert(nvarchar(10), @snapshot_date_in, 112), 112)))
	left outer join nav_account_process
		on  datepart(mi,nav_account_process.asof_time) = loadhist_definition.asof_minute 
		and	datepart(hh,nav_account_process.asof_time) = loadhist_definition.asof_hour
		and datepart(ss,nav_account_process.asof_time) = 0 
		and datepart(millisecond,nav_account_process.asof_time) = 0
		and ((@date_type = 1
				and account_audit.asof_time is not null 
				and nav_account_process.asof_time = account_audit.asof_time) 
			or (
				(@date_type = 0)
				 and convert(datetime, convert(nvarchar(10), nav_account_process.asof_time, 112), 112) = convert(datetime, convert(nvarchar(10), @snapshot_date_in, 112), 112))
			) 	
		and	nav_control_activation.account_id = nav_account_process.account_id 
		and	nav_account_process.deleted = 0
		and nav_account_process.nav_control_type_code = @specific_control_type
	where user_access_map.user_id = @current_user
		  and user_access_map.object_type in (2, 3)
	option (keepfixed plan, force order); 
	if @control_type = 0 
	begin
update #status_getnavaccttree 
		set
			current_dq_status = max_worst_data_qlty_status,
			current_result_status = max_worst_rule_status,
			focus_on_ok = 
				(
				select distinct 1 
				from nav_account_process nav_account_process_local
					join nav_control_type 
						on nav_account_process_local.nav_control_type_code = nav_control_type.nav_control_type_code
				where nav_account_process_local.account_id = #status_getnavaccttree.account_id and 
					nav_account_process_local.latest_cmpl_invocation_id = #status_getnavaccttree.cmpl_invocation_id and
					nav_account_process_local.nav_process_status_code = 6
				)
		from #status_getnavaccttree
		join (
				select 
					#status_getnavaccttree.account_id,
					#status_getnavaccttree.cmpl_invocation_id,
					max(nav_account_process.calc_worst_data_qlty_status) as max_worst_data_qlty_status,
					max(nav_account_process.calc_worst_rule_status) as max_worst_rule_status
				from #status_getnavaccttree 
				join nav_account_process
					on nav_account_process.account_id = #status_getnavaccttree.account_id 
					and nav_account_process.latest_cmpl_invocation_id = #status_getnavaccttree.cmpl_invocation_id
				group by #status_getnavaccttree.account_id, #status_getnavaccttree.cmpl_invocation_id
				) max_statuses
					on #status_getnavaccttree.account_id = max_statuses.account_id 
					and #status_getnavaccttree.cmpl_invocation_id = max_statuses.cmpl_invocation_id
		where #status_getnavaccttree.cmpl_invocation_id is not null;
		update #status_getnavaccttree
		set 
			current_process_status = 
				(select TOP 1
					nav_process_status_priority.nav_process_status_code 
				 from nav_process_status_priority
				 join nav_account_process
					on nav_account_process.nav_process_status_code = nav_process_status_priority.nav_process_status_code 
					and nav_account_process.account_id = #status_getnavaccttree.account_id
					and nav_account_process.asof_time = #status_getnavaccttree.asof_time 
					and (nav_account_process.latest_cmpl_invocation_id is null or nav_account_process.latest_cmpl_invocation_id = #status_getnavaccttree.cmpl_invocation_id)
				 order by nav_process_status_priority.nav_process_status_priority desc)
		where #status_getnavaccttree.status_calculated = 0;
	end else if @control_type = -1 begin
update #status_getnavaccttree 
		set
			current_dq_status = max_worst_data_qlty_status,
			current_result_status = max_worst_rule_status, 
			focus_on_ok = 
				(
				select distinct 1 
				from nav_account_process nav_account_process_local
					join nav_control_type 
						on nav_account_process_local.nav_control_type_code = nav_control_type.nav_control_type_code
						and nav_control_type.req_for_nav_publication = 1
				where nav_account_process_local.account_id = #status_getnavaccttree.account_id and 
					nav_account_process_local.latest_cmpl_invocation_id = #status_getnavaccttree.cmpl_invocation_id and
					nav_account_process_local.nav_process_status_code = 6
				)
		from #status_getnavaccttree
		join (
				select 
					#status_getnavaccttree.account_id,
					#status_getnavaccttree.cmpl_invocation_id,
					max(nav_account_process.calc_worst_data_qlty_status) as max_worst_data_qlty_status,
					max(nav_account_process.calc_worst_rule_status) as max_worst_rule_status
				from #status_getnavaccttree 
				join nav_account_process
					on nav_account_process.account_id = #status_getnavaccttree.account_id 
					and nav_account_process.latest_cmpl_invocation_id = #status_getnavaccttree.cmpl_invocation_id
				join nav_control_type 
					on nav_account_process.nav_control_type_code = nav_control_type.nav_control_type_code
					and nav_control_type.req_for_nav_publication = 1
				group by #status_getnavaccttree.account_id, #status_getnavaccttree.cmpl_invocation_id
				) max_statuses
					on #status_getnavaccttree.account_id = max_statuses.account_id 
					and #status_getnavaccttree.cmpl_invocation_id = max_statuses.cmpl_invocation_id
		where #status_getnavaccttree.cmpl_invocation_id is not null;
		update #status_getnavaccttree
		set 
			current_process_status = 
				(select TOP 1
					nav_process_status_priority.nav_process_status_code 
				 from nav_control_type
				 join nav_account_process
					on nav_account_process.nav_control_type_code = nav_control_type.nav_control_type_code
					and nav_account_process.account_id = #status_getnavaccttree.account_id 
					and nav_account_process.asof_time = #status_getnavaccttree.asof_time 
					and (nav_account_process.latest_cmpl_invocation_id is null or nav_account_process.latest_cmpl_invocation_id = #status_getnavaccttree.cmpl_invocation_id)
				 join nav_process_status_priority
					on nav_account_process.nav_process_status_code = nav_process_status_priority.nav_process_status_code 
				 where nav_control_type.req_for_nav_publication = 1
				 order by nav_process_status_priority.nav_process_status_priority desc)
		where #status_getnavaccttree.status_calculated = 0;
end;
	--select
	--	user_access_map.object_id as user_id, 
	--	0 as user_type_code,
	--	workgroup.name,
	--	case
	--		when user_access.object_id is not null then 1
	--		else 0
	--		end as is_top_level
	--from user_access_map
	--join workgroup
	--	on user_access_map.object_id = workgroup.workgroup_id
	--left outer join user_access
	--	on user_access_map.user_id = user_access.user_id
	--	and user_access_map.object_id = user_access.object_id
	--	and user_access_map.object_type = user_access.object_type
	--where user_access_map.user_id = @current_user
	--	and user_access_map.object_type = 0;
	--select
	--	distinct(account.account_id),
	--	account.account_level_code,
	--	account.short_name,
	--	account.client_account_id,
	--	#status_getnavaccttree.nav_date,
	--	#status_getnavaccttree.current_result_status,
	--	#status_getnavaccttree.current_dq_status,
 --       coalesce(#status_getnavaccttree.current_process_status, 3) as current_process_status,
 --       cmpl_invocation.invoked_time as last_invocation_time,
	--	#status_getnavaccttree.focus_on_ok as focus_on_ok
	--from #status_getnavaccttree
	--join account 
	--	on #status_getnavaccttree.account_id = account.account_id
 --   left outer join cmpl_invocation
	--	on #status_getnavaccttree.cmpl_invocation_id = cmpl_invocation.cmpl_invocation_id;
	--select 
	--	workgroup_tree.parent_id,
	--	workgroup_tree.child_id
	--from user_access_map
	--join workgroup_tree
	--	on user_access_map.object_id = workgroup_tree.parent_id
	--where user_access_map.user_id = @current_user
	--	and user_access_map.object_type = 0
	--	and exists
	--		( 
	--			select 1 
	--			from workgroup_tree_map
	--			where workgroup_tree.parent_id = workgroup_tree_map.parent_id
	--				and child_type = 3
	--		);
	--select
	--	account_hierarchy.parent_id,
	--	account_hierarchy.child_id
	--from #status_getnavaccttree
	--join account_hierarchy 
	--	on #status_getnavaccttree.account_id = account_hierarchy.parent_id
	--where account_hierarchy.parent_id <> account_hierarchy.child_id;
	--select
	--	workgroup_tree.parent_id as user_id,
	--	workgroup_tree.child_id as account_id 
	--from user_access_map
	--join workgroup_tree
	--	on user_access_map.object_id = workgroup_tree.parent_id
	--	and workgroup_tree.child_type in (2, 3)
	--where user_access_map.user_id = @current_user
	--	and user_access_map.object_type = 0;
		 
		--select * from #nav_results

		--select * from #status_getnavaccttree

		select 
	
		 #child_accounts.account_id,
		row_number() OVER (ORDER BY #child_accounts.parent_account_id) RowNumber,
		#child_accounts.Child_short_name,
		#child_accounts.parent_account_id,
		#child_accounts.parent_id,
		#child_accounts.Parent_short_name,
		#status_getnavaccttree.current_result_status,
		#status_getnavaccttree.current_dq_status,
		#status_getnavaccttree.current_process_status
		
		 from #child_accounts
		 join #status_getnavaccttree
		 on #status_getnavaccttree.account_id = #child_accounts.account_id
	
		 order by parent_id,#child_accounts.account_id
--select * from #nav_results
    return 0;
end

go
if @@error = 0 print 'PROCEDURE: se_get_nav_account_tree created'
else print 'PROCEDURE: se_get_nav_account_tree error on creation'
go

