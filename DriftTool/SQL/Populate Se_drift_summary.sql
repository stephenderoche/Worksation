

create table #all_accounts 
	(
		account_id numeric(10) not null
	);

								
insert into #all_accounts
(
	account_id
)
select account_id 
from account
where deleted = 0
and account.account_level_code = 2



declare @MInAccountID numeric(10);
declare @short_name varchar(40);
declare @model_name varchar(40);


 
 select @MInAccountID= min(#all_accounts.account_id)  
       from #all_accounts  
  

 while @MInAccountID is not null  
 begin 

 select @short_name = short_name from account where account_id = @MInAccountID
  select @model_name = name from model where model_id in (select default_model_id from account where account_id = @MInAccountID)



insert into se_drift_summary values(0,@MInAccountID,@short_name,@model_name,'N','N',0,'07/15/2018','10/15/2018',0,0,'Quarterly',0,0,0,0,0,0)
								
	

select @MInAccountID= min(#all_accounts.account_id)  
from #all_accounts   
 where #all_accounts.account_id >@MInAccountID 
 
 end
 
 drop table #all_accounts