if exists (select * from sysobjects where name = 'se_get_maturities')
begin
	drop procedure se_get_maturities
	print 'PROCEDURE: se_get_maturities dropped'
end
go
create PROCEDURE [dbo].[se_get_maturities] 
(
@account_id numeric(10),
@Date_offset numeric(10) = 60
)  
as  
begin  
  set @Date_offset = 2000
 set nocount on  
 declare @ec__errno int  
 declare  @toDate datetime =Getdate() + Coalesce(@Date_offset ,7),
 @fromDate datetime = Getdate()

 --------------------------------------------------------------------------------
 --  Create a temp table and populate with list of accounts the current user has
 --  access to.
 --  Note : user_access_map.object_type in (2, 3 ) is account groups objects types
 --------------------------------------------------------------------------------
 create table #acct 
 (
	account_id numeric(10) not null
 );

 --insert into #acct (account_id)
	--select distinct account.account_id 
	--from user_info
	--  join user_access on user_access.user_id = user_info.user_id  
	--  join user_access_map on user_access.user_id = user_access_map.user_id
	--  join account_hierarchy_map on user_access_map.object_id = account_hierarchy_map.parent_id
	--  join account on account_hierarchy_map.child_id = account.account_id
	--where user_info.domain_username = @domainUser
	--    and user_access_map.object_type in (2, 3 )
	--	and account.deleted = 0;

		insert into #acct 
	select
			        account.account_id
					from account_hierarchy_map
					join account on account_hierarchy_map.child_id = account.account_id
					where account_hierarchy_map.parent_id = @account_id 
						and account.account_level_code = 2
						and account.deleted = 0
						and account.ad_hoc_flag = 0
					    --and account.account_id <> @account_id

 --------------------------------------------------------------------------------
 --  Main data query returning a list of breach details
 --  including checking the user is allowed access to the particular accounts
 --------------------------------------------------------------------------------
select distinct Symbol,
account.short_name,
maturity_date,
(positions.quantity  
			* price.latest  
			* security.pricing_factor  
			* security.principal_factor  
			/ case when currency.exchange_rate is null then 1  
			 when currency.exchange_rate = 0 then 1  
			 else currency.exchange_rate  
			 end  
		   )  
		   +   
		   (positions.accrued_income  
			/ case when income_currency.exchange_rate is null then 1  
			 when income_currency.exchange_rate = 0 then 1  
			 else income_currency.exchange_rate  
			 end  
		   )  
		   * coalesce(position_type.security_sign, 1.0)as Cash
from security 
join positions on 
positions.security_id = security.security_id
join position_type   
		 on positions.position_type_code = position_type.position_type_code  
join account on
account.account_id = positions.account_id
join price
    on price.security_id = security.security_id
join currency
    on currency.security_id = security.principal_currency_id   --select * from security

join currency income_currency   
		on security.income_currency_id = income_currency.security_id  
where positions.account_id in (select account_id from #acct)
and maturity_date is not null
and security.maturity_date between @fromDate and dateadd(dd, 1, @toDate)
order by short_name desc,Symbol asc
 
 --------------------------------------------------------------------------------
 --  Tidy up
 --------------------------------------------------------------------------------
 drop table #acct 
 
end 
v

go
if @@error = 0 print 'PROCEDURE: se_get_maturities created'
else print 'PROCEDURE: se_get_maturities error on creation'
go
