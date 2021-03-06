if exists (select * from sysobjects where name = 'se_get_desk_trades')
begin
	drop procedure se_get_desk_trades
	print 'PROCEDURE: se_get_desk_trades dropped'
end
go

create procedure [dbo].[se_get_desk_trades]--se_get_desk_trades 28
(       
 @desk_id       numeric(10) = 1
 )      
as   
begin

create table #desk (desk_id numeric(10) not null);
insert into #desk
         select child_id
		 from desk 
		 join desk_tree_map on 
		 desk.desk_id = desk_tree_map.child_id  
		 where desk_tree_map.child_type = 4 
		 and desk_tree_map.parent_id = @desk_id



select desk.name,
security.symbol,
security.security_id,
side.mnemonic,
blocked_orders.block_id,
blocked_orders.quantity_ordered,
blocked_orders.quantity_executed,
blocked_orders.average_price_executed

from blocked_orders 
join security on
security.security_id = blocked_orders.security_id
join desk on
desk.desk_id = blocked_orders.trader_id
join side on
side.side_code = blocked_orders.side_code
where trader_id in (select desk_id from #desk)
and blocked_orders.deleted = 0 and security.major_asset_code = 1
 
END

go
if @@error = 0 print 'PROCEDURE: se_get_desk_trades created'
else print 'PROCEDURE: se_get_desk_trades error on creation'
go

--select * from desk


	 



		 --select * from desk_tree_map