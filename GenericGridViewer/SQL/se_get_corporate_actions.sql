if exists (select * from sysobjects where name = 'se_get_corporate_actions')
begin
	drop procedure se_get_corporate_actions
	print 'PROCEDURE: se_get_corporate_actions dropped'
end
go
create procedure [dbo].[se_get_corporate_actions] --se_get_corporate_actions
(     

 @account_id				 numeric(10) = -1,
 @security_id				 numeric(10) = -1


 )    
as 

begin
                        set nocount on;
                        declare @ec__errno int;
                        declare @sp_initial_trancount int;
                        declare @sp_trancount int;

						create table #acct 
 (
	account_id numeric(10) not null
 );

 insert into #acct 
	select
			        account.account_id
					from account_hierarchy_map
					join account on account_hierarchy_map.child_id = account.account_id
					where account_hierarchy_map.parent_id = @account_id 
						and account.account_level_code = 2
						and account.deleted = 0
						and account.ad_hoc_flag = 0


select 
Symbol + '- ' + corporate_action_type.description as corp,
Symbol,
corporate_action_type.description
,ex_date,pay_date,record_date,rate,ratio_or_percentage,corporate_actions.security_id ,
case 
  when processed = 0 then 'No'
  else 'Yes'
  end as processed,
  price.closing,
  price.latest
from corporate_actions
join security on
security.security_id = corporate_actions.security_id
join corporate_action_type on
corporate_action_type.corporate_action_type_code = corporate_actions.corporate_action_type_code
join price on 
price.security_id = corporate_actions.security_id
	
end


go
if @@error = 0 print 'PROCEDURE: se_get_corporate_actions created'
else print 'PROCEDURE: se_get_corporate_actions error on creation'
go

