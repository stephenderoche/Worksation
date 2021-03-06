if exists (select * from sysobjects where name = 'se_cmpl_get_breaches_by_servitiy')
begin
	drop procedure se_cmpl_get_breaches_by_servitiy
	print 'PROCEDURE: se_cmpl_get_breaches_by_servitiy dropped'
end
go


create procedure [dbo].[se_cmpl_get_breaches_by_servitiy]--se_cmpl_get_breaches_by_servitiy 74
(	
@account_id                   numeric(10),
@user_id						  smallint = 189
)
as 
	declare @ret_val					int;
	declare @continue_flag				int;
	declare @cps_rpx_breaches_by_sev_s	nvarchar(30);
	declare @cpe_rpx_breaches_by_sev_s	nvarchar(30);
	
begin
                        set nocount on;
                        declare @ec__errno int;
                        declare @sp_initial_trancount int;
                        declare @sp_trancount int;


create table #account  	(  		account_id numeric(10) not null  	);

   	insert into #account
	select
			        account.account_id
					from account_hierarchy_map
					join account on account_hierarchy_map.child_id = account.account_id
					where account_hierarchy_map.parent_id = @account_id 
						and account.account_level_code = 2
						and account.deleted = 0
						and account.ad_hoc_flag = 0

create table #severity_tbl
(
	severity nvarchar(30)
);

create table #distinct_cmpl_case_id
(
	cmpl_case_id numeric(10),
	name varchar(400),
	account_id numeric(10),
	noaction numeric(10),
	compliance_case_state numeric(10)
);


create table #max_invocation_case_id
(
	cmpl_case_id numeric(10),
	cmpl_case_invocation_id numeric(10),
	calc_worst_error_level numeric(10)
	
);



insert into #distinct_cmpl_case_id
select 
	distinct cmpl_case.cmpl_case_id,
	    cmpl_case.name,
		cmpl_case.compliance_account_id,
		cmpl_case.closed_noaction,
		cmpl_case.cmpl_case_state_id

		from cmpl_case
		 join cmpl_case_invocation 
			on cmpl_case_invocation.cmpl_case_id = cmpl_case.cmpl_case_id
			and cmpl_case_invocation.cmpl_case_id in 
			(
			SELECT  distinct  (cmpl_case_invocation.cmpl_case_id)
                FROM    cmpl_case_invocation where  
				cmpl_case_invocation.calc_worst_error_level > 0
            
			)
		join account 
			on account.account_id = cmpl_case.compliance_account_id and
			account.deleted = 0 and 
			account.account_level_code = 2 and 
			account.account_id in
			(
				--select distinct object_id
				--from user_access_map
				--where user_id = @user_id
				--	and object_type = 3
				select account_id from #account
			)
			where not coalesce (cmpl_case.closed_noaction,-1) = 0
			and cmpl_case_state_id = 0

--select * from #distinct_cmpl_case_id

insert into #max_invocation_case_id
SELECT  cmpl_case_id, MAX(cmpl_case_invocation_id),calc_worst_error_level
 FROM cmpl_case_invocation
where
cmpl_case_id in 
(
	
select cmpl_case_id from #distinct_cmpl_case_id
)

group by cmpl_case_id,calc_worst_error_level




insert into #severity_tbl values ('Passes');
insert into #severity_tbl values ('Warnings');
insert into #severity_tbl values ('Fails');
insert into #severity_tbl values ('Missing Data');
select 
    1 as country_id,
	#severity_tbl.severity as country,
	sum(temp_sev.total) as disclosures
from #severity_tbl
join (
		select
			case 
				when #max_invocation_case_id.calc_worst_error_level = 0 
					then 'Passes'
				when #max_invocation_case_id.calc_worst_error_level = 1 
					and #distinct_cmpl_case_id.name not like 'Missing Data%'
						then 'Warnings'
				when #max_invocation_case_id.calc_worst_error_level > 1 
					and #distinct_cmpl_case_id.name not like 'Missing Data%'
						then 'Fails'
				when #max_invocation_case_id.calc_worst_error_level > 0 
					and #distinct_cmpl_case_id.name like 'Missing Data%'
						then 'Missing Data'
				end as severity,
			case 
				when #max_invocation_case_id.calc_worst_error_level = 0 
					then count(#max_invocation_case_id.calc_worst_error_level )
				when #max_invocation_case_id.calc_worst_error_level = 1 
					and #distinct_cmpl_case_id.name not like 'Missing Data%'
						then count(#max_invocation_case_id.calc_worst_error_level )
				when #max_invocation_case_id.calc_worst_error_level > 1 
					and #distinct_cmpl_case_id.name not like 'Missing Data%'
						then count(#max_invocation_case_id.calc_worst_error_level )
				when #max_invocation_case_id.calc_worst_error_level > 0 
					and #distinct_cmpl_case_id.name like 'Missing Data%'
						then count(#max_invocation_case_id.calc_worst_error_level )
				end as total
		from #distinct_cmpl_case_id
		 join #max_invocation_case_id 
		   on #max_invocation_case_id.cmpl_case_id = #distinct_cmpl_case_id.cmpl_case_id
		
		--join account 
		--	on account.account_id = #distinct_cmpl_case_id.account_id and
		--	account.deleted = 0 and 
		--	account.account_level_code = 2 and 
		--	account.account_id in
		join account 
			on account.account_id = #distinct_cmpl_case_id.account_id and
			account.deleted = 0 and 
			account.account_level_code = 2 and 
			account.account_id in
			(
				select distinct object_id
				from user_access_map
				where user_id = @user_id
					and object_type = 3
			)
			where not coalesce (#distinct_cmpl_case_id.noaction,-1) = 0
			and #distinct_cmpl_case_id.compliance_case_state = 0
			
		group by 
		    #max_invocation_case_id.cmpl_case_id,
			#max_invocation_case_id.calc_worst_error_level , 
			#distinct_cmpl_case_id.name
	) temp_sev
	on 	upper(temp_sev.severity) = upper(#severity_tbl.severity)
	
group by #severity_tbl.severity;

return;
end




go
if @@error = 0 print 'PROCEDURE: se_cmpl_get_breaches_by_servitiy created'
else print 'PROCEDURE: se_cmpl_get_breaches_by_servitiy error on creation'
go