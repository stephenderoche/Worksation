USE [NAV_753]
GO
/****** Object:  StoredProcedure [dbo].[ng_rpt_results_matrix_rule]    Script Date: 11/20/2018 10:52:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[ng_rpt_results_matrix_rule] --exec ng_rpt_results_matrix_rule 33, 4, '2017-09-11', '2017-09-12'
(
	@account_id				numeric(10) 
	,@is_account smallint
	,@user_id int
	,@asof_time_start			datetime = null
	,@asof_time_end			datetime = null
)
as
begin

     set nocount on;

	create table #account (account_id numeric(10), short_name varchar(100))

	select @asof_time_end = @asof_time_start

	if @account_id = -1
		set @account_id = null

	insert into #account (account_id, short_name)

	select distinct a.account_id, a.short_name 
	from account a
		inner join account_hierarchy_map m on m.child_id = a.account_id
	where m.parent_id = IsNull(@account_id, m.parent_id)
		and m.child_type = 3

	select distinct ROW_NUMBER() over (order by account_id) as id, r.nav_control_type, p.cmpl_rule_id, cr.class_name as display_name, p.cmpl_profile_rule_id, rs.cmpl_profile_ruleset_id, rs.cmpl_profile_id, m.child_id as account_id, rt.cmpl_ruleset_rule_id
	into #accounts_profile
	from cmpl_profile cp 
		inner join cmpl_account_profile ap on ap.cmpl_profile_id = cp.cmpl_profile_id 
		inner join account_hierarchy_map m on m.parent_id = ap.account_id
		inner join cmpl_profile_ruleset rs on rs.cmpl_profile_id = cp.cmpl_profile_id and rs.deleted = 0
		inner join cmpl_ruleset r on r.cmpl_ruleset_id = rs.cmpl_ruleset_id
		inner join cmpl_ruleset_rule rt on r.cmpl_ruleset_id = rs.cmpl_ruleset_id
		inner join cmpl_profile_rule p on p.cmpl_profile_ruleset_id = rs.cmpl_profile_ruleset_id and p.cmpl_ruleset_rule_id = rt.cmpl_ruleset_rule_id and p.deleted = 0 
		inner join cmpl_rule cr on cr.cmpl_rule_id = p.cmpl_rule_id and cr.deleted = 0
	where cp.deleted = 0 and m.child_type = 3

	--select distinct rsv.value as param_val, ap.id, ap.cmpl_ruleset_rule_id
	--from #accounts_profile ap
	--	inner join cmpl_rule_param cp on ap.cmpl_rule_id = cp.cmpl_rule_id
	--	inner join cmpl_param_type ct on ct.cmpl_param_type_id =  cp.cmpl_param_type_id
	--	inner join cmpl_rsr_param_value rsv on rsv.cmpl_ruleset_rule_id = ap.cmpl_ruleset_rule_id and
	--			rsv.cmpl_rule_id = ap.cmpl_rule_id and
	--			rsv.cmpl_rule_param_id = cp.cmpl_rule_param_id and
	--			rsv.deleted = 0 
	--where cp.deleted = 0 
	--	and cp.cmpl_param_type_id in (5001)

	--select ap.id
	--	,case c.param_val when 1 then 'Fund' else 'Class' end + '/' + case b.param_val when 1 then 'Bal' else 'Act' end as param_val
	--	,ap.cmpl_rule_id
	--into #acct_param
	--from #accounts_profile ap
	--	inner join #account ac on ac.account_id = ap.account_id	
	--	inner join (select account_id, cmpl_rule_id, count(*) cnt from #accounts_profile group by account_id, cmpl_rule_id having count(*) > 1) as rc on rc.account_id = ap.account_id and rc.cmpl_rule_id = ap.cmpl_rule_id
	--	inner join (select rsv.value as param_val, ap.id
	--						from #accounts_profile ap
	--							inner join cmpl_rule_param cp on ap.cmpl_rule_id = cp.cmpl_rule_id
	--							inner join cmpl_param_type ct on ct.cmpl_param_type_id =  cp.cmpl_param_type_id
	--							left outer join cmpl_rsr_param_value rsv on rsv.cmpl_ruleset_rule_id = ap.cmpl_ruleset_rule_id and
	--									rsv.cmpl_rule_id = ap.cmpl_rule_id and
	--									rsv.cmpl_rule_param_id = cp.cmpl_rule_param_id and
	--									rsv.deleted = 0 
	--						where cp.deleted = 0 
	--							and cp.cmpl_param_type_id = 5001) b on b.id = ap.id
	--	inner join (select rsv.value as param_val, ap.id
	--						from #accounts_profile ap
	--							inner join cmpl_rule_param cp on ap.cmpl_rule_id = cp.cmpl_rule_id
	--							inner join cmpl_param_type ct on ct.cmpl_param_type_id =  cp.cmpl_param_type_id
	--							left outer join cmpl_rsr_param_value rsv on rsv.cmpl_ruleset_rule_id = ap.cmpl_ruleset_rule_id and
	--									rsv.cmpl_rule_id = ap.cmpl_rule_id and
	--									rsv.cmpl_rule_param_id = cp.cmpl_rule_param_id and
	--									rsv.deleted = 0 
	--						where cp.deleted = 0 
	--							and cp.cmpl_param_type_id = 5003) c on c.id = ap.id

	;with cte_nav_control_type_inv as (
		select n.account_id
			,a.short_name
			,n.nav_control_type_code 
			,MAX(n.latest_cmpl_invocation_id) as cmpl_invocation_id
		from nav_control_type t 
			inner join nav_account_process n on n.nav_control_type_code = t.nav_control_type_code
			inner join #account a on a.account_id = n.account_id
		where t.deleted = 0
			and n.deleted = 0
			and convert(datetime, convert(nvarchar(10), n.asof_time, 112), 112) = convert(datetime, convert(nvarchar(10), @asof_time_start, 112), 112) 
		group by n.account_id
			,n.nav_control_type_code 
			,a.short_name
	)	
	select distinct a.id, c.account_id
			,c.short_name as account_name
			, c.cmpl_invocation_id
			,case when rv.nav_status_ok = 1 then 'NAV Ok' when rv.nav_status_ok = 0 then 'NAV Not Ok' else '' end as rule_process_status
			,a.display_name as rule_name 
			,case when c.cmpl_invocation_id is null then 'N' when sr.nav_rule_status_code in (3,4) then 'F' when sr.nav_rule_status_code = 2 then 'U' else 'P' end  as rule_status
			,IsNull(dq.name, '') as data_status
			,IsNull(td3.data, '') + ' ' + IsNull(td1.data, '') as review_comment_1
			,IsNull(td4.data, '') + ' ' + IsNull(td2.data, '') as review_comment_2
			,u1.name as review_by_1
			,u2.name as review_by_2
			,rv.nav_res_ruleset_review_id
			,n.nav_res_rule_result_id
			,n.nav_rule_status_code
			,case when sr.nav_rule_status_code in (3,4) then 1 when sr.nav_rule_status_code = 1 then 0 when sr.nav_rule_status_code = 2 then -1 else -2 end as pass_fail
			,@asof_time_start as asof_time
			,cmpl_ruleset_rule_id
	into #matrix_data
	from cte_nav_control_type_inv c
		inner join #accounts_profile a on a.nav_control_type = c.nav_control_type_code and a.account_id = c.account_id
		left join nav_res_ruleset_review rv on rv.account_id = c.account_id and rv.cmpl_profile_ruleset_id = a.cmpl_profile_ruleset_id and rv.cmpl_invocation_id = c.cmpl_invocation_id
		left join nav_res_rule_result n on n.nav_res_ruleset_review_id = rv.nav_res_ruleset_review_id and n.cmpl_profile_rule_id = a.cmpl_profile_rule_id 
		left join nav_rule_status sr on sr.nav_rule_status_code = n.nav_rule_status_code 
		left join nav_data_quality_status dq on  n.nav_data_quality_status_code = dq.nav_data_quality_status_code
		left join cmpl_long_text_data td3 on td3.cmpl_long_text_id = n.first_rev_comment_text_id
		left join cmpl_long_text_data td4 on td4.cmpl_long_text_id = n.second_rev_comment_text_id
		left join cmpl_long_text_data td1 on td1.cmpl_long_text_id = rv.first_rev_comment_text_id
		left join cmpl_long_text_data td2 on td2.cmpl_long_text_id = rv.second_rev_comment_text_id
		left join user_info u1 on u1.user_id = rv.first_rev_by 
		left join user_info u2 on u2.user_id = rv.second_rev_by 

--select * from #matrix_data return 		

	declare @columns nvarchar(max), @sql nvarchar(max);
	set @columns = N'';

	select @columns += N', p.' + quotename(display_name)
	  from (select distinct p.class_name as display_name 
			from cmpl_rule as p 		
				inner join cmpl_profile_rule a on a.cmpl_rule_id = p.cmpl_rule_id				
			where p.deleted = 0 and p.standard_rule = 0 and a.deleted = 0 ) as x order by x.display_name;

	set @sql = N'
	select asof_time
		,account_name
		,account_id, ' + STUFF(@columns, 1, 2, '') + '
	from
	(
	  select p.asof_time
		,p.account_name
		,p.account_id
		,p.rule_name
		,p.rule_status
		,cmpl_ruleset_rule_id
	   from #matrix_data as p
	) as j
	pivot
	(
	  min(rule_status) for rule_name in ('
	  + stuff(replace(@columns, ', p.[', ',['), 1, 1, '')
	  + ')
	) as p
	order by account_name;'
	print @sql;

	exec sp_executesql @sql;



end

