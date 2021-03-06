if exists (select * from sysobjects where name = 'se_get_wash_sale_viewer')
begin
	drop procedure se_get_wash_sale_viewer
	print 'PROCEDURE: se_get_wash_sale_viewer dropped'
end
go

create procedure [dbo].[se_get_wash_sale_viewer]--exec se_get_wash_sale_viewer 10325
(       
 @account_id      numeric(10)

 )      
as    

begin    
declare @MInAccountID numeric(10);
declare @market_value float;
declare @t_minus_31     DATETIME; 
declare @run_time       DATETIME;

set nocount on 

select  @run_time = getdate()
SELECT  @t_minus_31 = dateadd(dd, -31, @run_time)  

   create table #account (account_id numeric(10) not null,short_name varchar(40));
 insert into #account  
		  select
			        account.account_id,
					short_name
					from account_hierarchy_map
					join account on account_hierarchy_map.child_id = account.account_id
					where account_hierarchy_map.parent_id = @account_id 
						and account.account_level_code = 2
						and account.deleted = 0
						and account.ad_hoc_flag = 0;


select 
CONVERT(VARCHAR(10),trade_date,10) as trade_date,
pfid,
symbol,
real_gain_loss,
'Potential Wash BUY because shares sold at a loss within last 31 days' as type
into #buy
from psg_bcp_wash_sale_list where pfid in (select short_name from #account)

--select * from #buy



select 
CONVERT(VARCHAR(10),trade_date,10) as 'trade_date',
account.short_name as 'pfid',
security.symbol as symbol,
quantity * (( price.latest - unit_cost)* pricing_factor* principal_factor)/currency.exchange_rate as real_gain_loss,
'Potential Wash SELL becuase shares purchased in last 31 days and has a loss' as type
into #sell
from tax_lot
join Price on
price.security_id = tax_lot.security_id
join account on
account.account_id in (select account_id from #account)
and tax_lot.account_id = account.account_id
join security on 
security.security_id = tax_lot.security_id
join currency on
currency.security_id = security.principal_currency_id
where tax_lot.account_id in (select account_id from #account)
and price.latest < tax_lot.unit_cost
and   trade_date > @t_minus_31

--select * from #sell

select 
* from 
#sell
union
select * from 
#buy

 end



go
if @@error = 0 print 'PROCEDURE: se_get_wash_sale_viewer created'
else print 'PROCEDURE: se_get_wash_sale_viewer error on creation'
go