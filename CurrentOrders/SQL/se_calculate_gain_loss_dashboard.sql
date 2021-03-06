  --select * from proposed_orders
if exists (select * from sysobjects where name = 'se_calculate_gain_loss_dashboard')
begin
	drop procedure se_calculate_gain_loss_dashboard
	print 'PROCEDURE: se_calculate_gain_loss_dashboard dropped'
end
go


/*
 declare @FltGainLoss float,
	@FstGainLoss float


	exec se_calculate_gain_loss_dashboard @FltGainLoss = @FltGainLoss output,@FstGainLoss = @FstGainLoss output,@price_previous = 9.60,@account_id= 93,
	@security_id=2184,@order_id = 18415

	print @FltGainLoss
	print @FstGainLoss
*/


--select * from order_tax_lot 
--	select * from proposed_orders where proposed_orders.account_id = 93 and proposed_orders.security_id = 2184




create proc [dbo].[se_calculate_gain_loss_dashboard]--se_calculate_gain_loss 93,1482,18407,0
(

    @FltGainLoss float output,
	@FstGainLoss float output,
	@price_previous float,
	@account_id		numeric(10), 
	@security_id	numeric(10),
	@order_id numeric(10) = 0,
	@total tinyint = 0,
	@position_type	tinyint = 0

)
as
set nocount on
/* set ansi_warnings off */


	select @price_previous = price.latest from price where security_id = @security_id

	CREATE TABLE #temp_tax_lot
	(
		tax_lot_id			NUMERIC(10),
		trade_date			DATETIME,
		order_tl_quantity	FLOAT NULL
	)
	
	INSERT	#temp_tax_lot (tax_lot_id, trade_date, order_tl_quantity)
	SELECT	tax_lot.tax_lot_id,
			tax_lot.trade_date,
			0				/* user_field_8  - set to 0.0 */
	FROM	tax_lot, 
			account_hierarchy_map, 
			account
	WHERE	account_hierarchy_map.parent_id = @account_id
	AND		account_hierarchy_map.child_id = tax_lot.account_id
	AND		account.account_id = tax_lot.account_id 
	AND		account.deleted = 0
	AND		tax_lot.position_type_code = @position_type
	AND		tax_lot.security_id = @security_id
	
	

	/* Update the qty in user_field_8 for the records in order_tax_lot,
	   this will be used when a user manually selects a tax lot to sell off */

	if @total = 0 
	   Begin
			UPDATE #temp_tax_lot
			SET order_tl_quantity = order_tax_lot.quantity
			FROM order_tax_lot
			WHERE #temp_tax_lot.tax_lot_id = order_tax_lot.tax_lot_id
			and order_tax_lot.order_id = @order_id
			and order_tax_lot.deleted = 0
	  end
	else
	  begin
			UPDATE #temp_tax_lot
			SET order_tl_quantity = order_tax_lot.quantity
			FROM order_tax_lot
			WHERE #temp_tax_lot.tax_lot_id = order_tax_lot.tax_lot_id
			and order_tax_lot.deleted = 0
	  end

    /* Proposed LT Gain/Loss */
	SELECT	@FltGainLoss = 
	ISNULL(round(SUM((ISNULL(@price_previous,0.0) - ISNULL(tax_lot.unit_cost,0.0)) * #temp_tax_lot.order_tl_quantity), 2), 0.0)
	FROM	tax_lot,
			#temp_tax_lot
	WHERE 	tax_lot.tax_lot_id = #temp_tax_lot.tax_lot_id
	AND DATEDIFF(DAY, DATEADD(YEAR, 1, tax_lot.trade_date), GETDATE()) >= 1

	/* Proposed ST Gain/Loss */
	SELECT	@FstGainLoss = 
	ISNULL(round(SUM((ISNULL(@price_previous,0.0) - ISNULL(tax_lot.unit_cost,0.0)) * #temp_tax_lot.order_tl_quantity), 2), 0.0)
	FROM	tax_lot,
			#temp_tax_lot
	WHERE 	tax_lot.tax_lot_id = #temp_tax_lot.tax_lot_id
	AND DATEDIFF(DAY, DATEADD(YEAR, 1, tax_lot.trade_date), GETDATE()) < 1


--Results Set
--SELECT	@FstGainLoss as st_gainloss,
--		@FltGainLoss as lt_gainloss,
--		isnull((@FstGainLoss + @FltGainLoss), 0)   as total_gainloss

		--if (@type = 1)
		--begin
		--     select @FstGainLoss as st_gainloss
		--end

		--if (@type = 2)
		--begin
		--     select @FltGainLoss as lt_gainloss
		--end

		--if (@type = 3)
		--begin
		--     select isnull((@FstGainLoss + @FltGainLoss), 0)   as total_gainloss
		--end


		
		     --select @FstGainLoss 
		
		     --select @FltGainLoss 
		
		   
		
		
		
			
RETURN 

go
if @@error = 0 print 'PROCEDURE: se_calculate_gain_loss_dashboard created'
else print 'PROCEDURE: se_calculate_gain_loss_dashboard error on creation'
go