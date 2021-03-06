  --select * from proposed_orders
if exists (select * from sysobjects where name = 'se_get_drift_mv')
begin
	drop procedure se_get_drift_mv
	print 'PROCEDURE: se_get_drift_mv dropped'
end
go

/*
declare  @drift_market_value numeric(10)

exec se_get_drift_mv  
@drift_market_value =  @drift_market_value output, 
@account_id  =20444,
@model_id = 162905, 
@security_id = 7276,
@account_market_value= 1000000

print @drift_market_value

*/


create  procedure [dbo].[se_get_drift_mv] --se_get_drift_mv 20490
(   
 @drift_market_value numeric(10) output,
 @account_id numeric(10),
 @Model_id numeric(10),
 @security_id numeric(10),
 @account_market_value float
 
 )
 
as  
declare  @Model_target float,
         @security_mv float



begin

select @Model_target = target from model_security where model_id = @Model_id and security_id = @security_id
print @Model_target
 

exec se_get_security_mv @security_mv = @security_mv output, @account_id  =@account_id, @security_id = @security_id,@market_value_type = 3,@account_market_value = @account_market_value
print @security_mv

select @drift_market_value = coalesce(@security_mv,0) - (coalesce(@Model_target,0)*@account_market_value)

return 

	
        
        
 
end  


go
if @@error = 0 print 'PROCEDURE: se_get_drift_mv created'
else print 'PROCEDURE: se_get_drift_mv error on creation'
go

 
