if exists (select * from sysobjects where name = 'se_get_currency_mvmt_report_sum')
begin
	drop procedure se_get_currency_mvmt_report_sum
	print 'PROCEDURE: se_get_currency_mvmt_report_sum dropped'
end
go


/*
se_get_currency_mvmt_report_sum '2018/5/1 00:00:00.000 ', '2018/5/8 00:00:00.000 ', 199, null, 
1.00000000, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 189.00000000

se_get_currency_mvmt_report_sum  199,1, 189.00000000

*/
create procedure [dbo].[se_get_currency_mvmt_report_sum]
(
	@account_id 				numeric(10) = null,
	@display_currency_id		numeric(10) = null,
	@current_user numeric(10) = 189
) 
as
	declare @fx_trade_sec_id			numeric(10);
	declare	@fx_settle_sec_id			numeric(10);	
	declare @system_currency_id			numeric(10);
	declare @fx_current_date			datetime;
	declare @fx_settle_spot_rate		float;
	declare @fx_trade_to_settle_rate	float;
	declare @maximum_date_range_string	nvarchar(13);
	declare @exchange_code				numeric(10);
	declare @major_asset_code			smallint;
	declare @minor_asset_code			smallint;
	declare @bond_type_code				smallint;
	declare @issuer_type_code			tinyint;
	declare @delivery_code				smallint;
	declare @unconfirmed_settle_mvmt	tinyint;
	declare @confirmed_settle_mvmt		tinyint;
	declare @unconfirmed_spot_mvmt		tinyint;
	declare @confirmed_spot_mvmt		tinyint;
	declare @cash_position_mvmt			tinyint;
	declare @display_exchange_rate		float;
	declare @display_mnemonic			nvarchar(8);
	declare @exchange_country_code		numeric(10);
	declare @valid_settle_day			tinyint;
	declare @settlement_date			datetime;
	declare @current_date				nvarchar(11);
	declare @maximum_date_range			int;
	declare @security_id				numeric(10);
	declare @order_id					numeric(10);
	declare @offset						int;
	declare @trade_date					datetime;
	declare @valid_trade_day			tinyint;
	declare @trade_date_offset			tinyint;
	declare @allocations_sum			int;
	declare @ret_val int;
	declare @continue_flag				bit;
	declare @cps_get_currency_mvmt_report nvarchar(30);
	declare @cpe_get_currency_mvmt_report nvarchar(30);
	declare @display_currency_local		numeric(10);

     declare 	@from_date		datetime, 
	@end_date					datetime, 
	@workgroup_id 				int = null,
	@proposed_equity_flag		tinyint = 1,
	@proposed_equity_ipo_flag	tinyint = 1,
	@proposed_eqty_sec_off_flag	tinyint = 1,
	@proposed_debt_flag			tinyint = 1,
	@proposed_fund_flag			tinyint = 1,
	@proposed_future_flag		tinyint = 1,
	@proposed_forward_flag		tinyint = 1,
	@proposed_option_flag		tinyint = 1,
	@proposed_index_flag		tinyint = 1,
	@proposed_unclassified_flag	tinyint = 1,
	@proposed_spot_flag			tinyint = 1,
	@ordered_equity_flag		tinyint = 1,
	@ordered_equity_ipo_flag	tinyint = 1,
	@ordered_eqty_sec_off_flag	tinyint = 1,
	@ordered_debt_flag			tinyint = 1,
	@ordered_fund_flag			tinyint = 1,
	@ordered_future_flag		tinyint = 1,
	@ordered_forward_flag		tinyint = 1,
	@ordered_option_flag		tinyint = 1,
	@ordered_index_flag			tinyint = 1,
	@ordered_unclassified_flag	tinyint = 1,
	@ordered_spot_flag			tinyint = 1
begin
                        set nocount on;
                        declare @ec__errno int;
                        declare @sp_initial_trancount int;
                        declare @sp_trancount int;
	create table #opening_alloc_totals  	(  		security_id						numeric(10) null,  		account_id						numeric(10) null,  		position_type_code				tinyint null,  		total_opening_alloc_cost		float null,  		total_opening_alloc_quantity	float null  	);
	create table #user_ccy_mvmt_type  	(  		ccy_mvmt_type_code smallint null  	);
	create table #driver_gcmr  	(  		account_id				numeric(10) null,  		currency_code			numeric(10) null,  		security_id				numeric(10) null,  		ticket_type_code		tinyint null,  		quantity				float null,  		effective_date			datetime null,  		currency_exchange_rate	float null,  		mkt_val_display_curr	float null,  		multiplier_sign			smallint null,  		price					float null,  		pricing_factor			float null,  		principal_factor		float null,  		accrued_income			float null,  		share_indicator			bit null,  		contract_size			float null,  		commission				float null  	);
	create table #ordered_driver_ccy  	(  		account_id					numeric(10) null,  		security_id					numeric(10) null,  		order_id					numeric(10) null,  		exchange_country_code		numeric(10) null,  		currency_code				numeric(10) null,  		quantity					float null,  		effective_date				datetime null,  		currency_exchange_rate		float null,  		mkt_val_display_curr		float null,  		multiplier_sign				smallint,  		price						float null, 		pricing_factor				float null,  		principal_factor			float null, 		accrued_income				float null,  		share_indicator				bit null,  		contract_size				float null  	);
	create table #proposed_driver_gcmr  	(  		account_id				numeric(10) null,  		security_id				numeric(10) null,  		order_id				numeric(10) null,  		exchange_country_code	numeric(10) null,  		currency_code			numeric(10) null,  		quantity				float null,  		effective_date			datetime null,  		currency_exchange_rate	float null,  		mkt_val_display_curr	float null,  		multiplier_sign			smallint null,  		price					float null,  		pricing_factor			float null,  		principal_factor		float null,  		accrued_income			float null,  		share_indicator			bit null,  		contract_size			float null 	);
	create table #ordered_settle_date_driver  	(  		order_id  numeric(10) null,  		security_id numeric(10) null,  		exchange_country_code numeric(10) null  	);
	create table #proposed_trade_date_driver   	(  		order_id numeric(10),  		security_id numeric(10),  		exchange_country_code int null  	);
	create table #final_driver_gcmr  	(  		account_id					numeric(10) null,  		currency_code				numeric(10) null,  		quantity					float null,  		effective_date				datetime null,  		mkt_val_display_currency	float null,  		currency_exchange_rate		float null,  		price						float null,  		multiplier_sign				smallint null  	);
	create table #almost_final_driver_gcmr  	( sumMV float,account_id					numeric(10) null,  		currency_code				numeric(10) null)
	create table #forward_info  	(  		security_id numeric(10) null,  		trade_to_settle_rate float null,  		settle_spot_rate float null  	);
	create table #account  	(  		account_id numeric(10) not null  	);
	create table #alloc_qty_gcmr  	(  		order_id				numeric(10),  		allocations_qty			float null,  		ticket_type_code		tinyint null,  		principal_currency_id	numeric(10) null,  		side_code				tinyint null  	);
	select @unconfirmed_settle_mvmt = 0;
	select @confirmed_settle_mvmt = 1;
	select @unconfirmed_spot_mvmt = 2;
	select @confirmed_spot_mvmt = 3;
	select @cash_position_mvmt = 15;
	

	select @current_date = convert(datetime, convert(nvarchar(10), getdate(), 112), 112);	
	select @from_date = @current_date
	select @end_date = @from_date + 7
	select @maximum_date_range = convert(int,  value) 
	from registry 
	where section = 'CURRENCY PROJECTION REPORT' and
		  entry = 'MAXIMUM DATE RANGE';
	if @maximum_date_range is null
	begin
		select @maximum_date_range = 35;
	end;
	if @from_date < @current_date
	begin		
		raiserror(50306, 10, -1);
		return 50306;
	end; 
	if @maximum_date_range > 35
	begin
		raiserror(60081, 10, -1);
		select @maximum_date_range = 35;
	end; 
	if datediff(dd,  @from_date,  @end_date) > @maximum_date_range
	begin	
		select @maximum_date_range_string = cast(@maximum_date_range as nvarchar(13)) ;
		raiserror(50307, 10, -1,  @maximum_date_range_string);
		return 50307;
	end; 
	if @display_currency_id is null 
	begin
		select @display_currency_local = security_id 
		from currency 
		where system_currency = 1;
	end else begin
		select @display_currency_local = @display_currency_id;
	end;
	select 
		@display_exchange_rate = exchange_rate,
		@display_mnemonic = mnemonic
	from currency 
	where security_id = @display_currency_local;
	if @account_id is not null
	begin
		insert into #account 
		(
			account_id
		)
		select account_hierarchy_map.child_id
		from 
			account_hierarchy_map, 
			account
		where
			account_hierarchy_map.child_id = account.account_id and
			account_hierarchy_map.parent_id = @account_id and
			account.major_account_code <> 1 and
			account.account_level_code <> 1;
	end;
	if @workgroup_id is not null
	begin
		insert into #account
		(
			account_id
		)
		select 
			distinct account.account_id
		from 
			workgroup_tree_map, 
			 account
		where
			workgroup_tree_map.child_id = account.account_id and
			workgroup_tree_map.parent_id = @workgroup_id and
			account.major_account_code <> 1 and
			account.account_level_code <> 1 
		option (keepfixed plan);
	end;
	insert into #user_ccy_mvmt_type
	(
		ccy_mvmt_type_code
	)
	select 
		ccy_mvmt_type_code
	from user_currency_movement_type
	where user_id = @current_user
	option (keepfixed plan);
	insert into #driver_gcmr 
	(
		account_id,
		currency_code,
		security_id,
		ticket_type_code,
		quantity,
		effective_date,
		currency_exchange_rate,
		multiplier_sign,
		price
	)
	select 
		currency_movement.account_id,
		currency_movement.currency_code,
		currency_movement.security_id,
		currency_movement.ticket_type_code,
		currency_movement.quantity, 
		currency_movement.effective_date,
		currency.exchange_rate,
		1,
		1
	from 
		#account,
		currency_movement,
		#user_ccy_mvmt_type,
		currency
	where 
		#account.account_id = currency_movement.account_id and
		currency.security_id = currency_movement.currency_code and
		currency_movement.effective_date >= @from_date and
		currency_movement.effective_date <= @end_date and
		currency_movement.ccy_mvmt_type_code = #user_ccy_mvmt_type.ccy_mvmt_type_code and
		currency_movement.ccy_mvmt_type_code not in 
			(@unconfirmed_settle_mvmt, 
			@confirmed_settle_mvmt, 
			@unconfirmed_spot_mvmt,
			@confirmed_spot_mvmt, 
			@cash_position_mvmt)
	option (keepfixed plan);
	if exists(
		select 1 
		from #user_ccy_mvmt_type 
		where ccy_mvmt_type_code = @cash_position_mvmt
	) begin
		insert into #driver_gcmr 
		(
			account_id,
			currency_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price
		)
		select 
			positions.account_id,
			security.principal_currency_id,
			positions.quantity,
			@current_date,
			currency.exchange_rate,
			position_type.security_sign,
			1
		from 
			#account,
			positions,
			security,
			currency,
			position_type
		where 
			#account.account_id = positions.account_id and
			positions.security_id = security.security_id and
			security.major_asset_code = 0 and
			security.security_id = currency.security_id and
			positions.position_type_code = position_type.position_type_code and
			security.deleted = 0 and
			@current_date >= @from_date and
			@current_date <= @end_date
		option (keepfixed plan);
		insert into #driver_gcmr 
		(
			account_id,
			currency_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price
		)
		select 
			positions.account_id,
			security.principal_currency_id,
			positions.quantity,
			@current_date,
			currency.exchange_rate,
			position_type.security_sign,
			1
		from 
			#account,
			positions,
			security,
			currency,
			position_type
		where 
			#account.account_id = positions.account_id and
			positions.security_id = security.security_id and
			security.major_asset_code = 0 and
			security.principal_currency_id = currency.security_id and
			security.minor_asset_code in (2, 1) and
			positions.position_type_code = position_type.position_type_code and
			security.deleted = 0 and
			@current_date >= @from_date and
			@current_date <= @end_date
		option (keepfixed plan);
	end; 
	if exists(	select 1 
		from #user_ccy_mvmt_type 
		where ccy_mvmt_type_code = @unconfirmed_settle_mvmt
	) begin
		insert into #driver_gcmr
		(
			account_id,
			currency_code,
			security_id,
			ticket_type_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price
		)
		select
			allocations.account_id,
			allocations.settlement_currency_id,
			allocations.security_id,
			ticket.ticket_type_code,
			case
				when ticket.ticket_type_code in (5, 13)
				     and ticket.settlement_currency_id != coalesce(security.principal_currency_id, -1)
					 and coalesce(ticket.settlement_fx_rate, 0) != 0
				then
					case when coalesce(cross_currency.direction, 1 - cross_currency_inverted.direction, 0) = 0
						then
							round(allocations.net_amount / ticket.settlement_fx_rate, currency.market_value_rounding)
						else
							round(allocations.net_amount * ticket.settlement_fx_rate, currency.market_value_rounding)
					end
				else
					allocations.net_amount
			end,
			ticket.settlement_date,
			currency.exchange_rate,
			side.market_value_sign,
			1
		from 
			#account
			join allocations
				on #account.account_id = allocations.account_id 
			join ticket 
				on allocations.ticket_id = ticket.ticket_id
			join side 
				on allocations.side_code = side.side_code
			join currency
				on allocations.settlement_currency_id = currency.security_id
			join security
				on allocations.security_id = security.security_id
			left outer join cross_currency
				on security.principal_currency_id = cross_currency.principal_currency_id 
				and ticket.settlement_currency_id = cross_currency.counter_currency_id
			left outer join cross_currency cross_currency_inverted
				on security.principal_currency_id = cross_currency_inverted.counter_currency_id
				and ticket.settlement_currency_id = cross_currency_inverted.principal_currency_id
		where
			ticket.settlement_date >= @from_date and
			ticket.settlement_date <= @end_date and
			ticket.ticket_type_code not in (12, 8, 7) and
			ticket.deleted = 0 and
			allocations.primary_confirmed = 0 and 
			allocations.primary_canceled = 0 and
			allocations.primary_pending = 0 and
			allocations.deleted = 0 
		option (keepfixed plan);
		insert into #driver_gcmr
		(
			account_id,
			currency_code,
			security_id,
			ticket_type_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price
		)
		select
			allocations.account_id,
			allocations.settlement_currency_id,
			allocations.security_id,
			ticket.ticket_type_code,
			case
				when ticket.ticket_type_code in (5, 13)
				     and ticket.settlement_currency_id != coalesce(security.principal_currency_id, -1)
					 and coalesce(ticket.settlement_fx_rate, 0) != 0
				then
					case when coalesce(cross_currency.direction, 1 - cross_currency_inverted.direction, 0) = 0
						then
							round(allocations.net_amount / ticket.settlement_fx_rate, currency.market_value_rounding)
						else
							round(allocations.net_amount * ticket.settlement_fx_rate, currency.market_value_rounding)
					end
				else
					allocations.net_amount
			end,
			ticket.settlement_date,
			currency.exchange_rate,
			side.market_value_sign,
			1
		from
			#account
			join allocations
				on #account.account_id = allocations.account_id 
			join ticket 
				on allocations.ticket_id = ticket.ticket_id
			join side 
				on allocations.side_code = side.side_code
			join currency
				on allocations.settlement_currency_id = currency.security_id
			join security
				on allocations.security_id = security.security_id
			left outer join cross_currency
				on security.principal_currency_id = cross_currency.principal_currency_id 
				and ticket.settlement_currency_id = cross_currency.counter_currency_id
			left outer join cross_currency cross_currency_inverted
				on security.principal_currency_id = cross_currency_inverted.counter_currency_id
				and ticket.settlement_currency_id = cross_currency_inverted.principal_currency_id
		where
			ticket.settlement_date >= @from_date and
			ticket.settlement_date <= @end_date and
			ticket.ticket_type_code not in (12, 8, 7) and
			ticket.deleted = 0 and
			((allocations.primary_confirmed = 1 and allocations.modified = 1) or
			(allocations.primary_pending = 1 and allocations.modified = 0)) and
			allocations.primary_canceled = 0 and
			allocations.deleted = 0 
		option (keepfixed plan);
		if (@ordered_future_flag = 1)
		begin
			insert into #opening_alloc_totals
			(
				security_id,					
				account_id,					
				position_type_code,			
				total_opening_alloc_cost,	
				total_opening_alloc_quantity
			)
			select 
				allocations.security_id security_id,
				allocations.account_id account_id,
				side.position_type_code position_type_code,
				sum(allocations.quantity * allocations.price) total_opening_alloc_cost,
				sum(allocations.quantity) total_opening_alloc_quantity
			from allocations, 
				 ticket, 
				 side,
				 #account
			where #account.account_id = allocations.account_id
				and allocations.ticket_id = ticket.ticket_id
				and ticket.ticket_type_code = 7
				and side.side_code = allocations.side_code
				and side.buy_indicator = 1
				and allocations.deleted = 0
				and allocations.primary_confirmed = 0
				and allocations.archived = 0
			group by 
				allocations.account_id,
				allocations.security_id,
				side.position_type_code
			option (keepfixed plan);
			insert into #driver_gcmr
			(
				account_id,
				currency_code,
				security_id,
				ticket_type_code,
				quantity,
				effective_date,
				currency_exchange_rate,
				multiplier_sign,
				price,
				pricing_factor,
				principal_factor,
				share_indicator,
				contract_size,
				commission
			)
			select
				allocations.account_id,
				allocations.settlement_currency_id,
				allocations.security_id,
				ticket.ticket_type_code,
				case
					when side.buy_indicator = 1
						then 0
						else allocations.quantity
					end,
				ticket.settlement_date,
				currency.exchange_rate,
				side.market_value_sign,
				case
					when coalesce(positions.quantity, 0) = 0
						then allocations.price
						else allocations.price - ((positions.quantity * coalesce(positions.last_mark, positions.unit_cost, 0) + coalesce(#opening_alloc_totals.total_opening_alloc_cost, 0)) / (coalesce(#opening_alloc_totals.total_opening_alloc_quantity, 0) + positions.quantity))
					end,
				security.pricing_factor,
				security.principal_factor,
				side.share_indicator,
				security.contract_size,
				allocations.commission + allocations.taxes + allocations.other_charges + allocations.local_commission + allocations.exchange_fee + allocations.stamp_tax + allocations.levy + allocations.other_taxes_fees
			from 
				#account
				join allocations
					on #account.account_id = allocations.account_id
				join currency
					on allocations.settlement_currency_id = currency.security_id
				join ticket
					on allocations.ticket_id = ticket.ticket_id
				join side
					on allocations.side_code = side.side_code
				join security
					on security.security_id = allocations.security_id
				left outer join positions
					on positions.account_id = allocations.account_id and
					   positions.security_id = allocations.security_id and
					   positions.position_type_code = side.position_type_code
				left outer join #opening_alloc_totals
					on #opening_alloc_totals.account_id = allocations.account_id and
					   #opening_alloc_totals.security_id = allocations.security_id and
					   #opening_alloc_totals.position_type_code = side.position_type_code
			where 
				ticket.settlement_date >= @from_date and
				ticket.settlement_date <= @end_date and
				ticket.ticket_type_code = 7 and
				ticket.deleted = 0 and
				allocations.primary_confirmed = 0 and 
				allocations.primary_canceled = 0 and
				allocations.primary_pending = 0 and
				allocations.deleted = 0 
			option (keepfixed plan);
			insert into #driver_gcmr
			(
				account_id,
				currency_code,
				security_id,
				ticket_type_code,
				quantity,
				effective_date,
				currency_exchange_rate,
				multiplier_sign,
				price,
				pricing_factor,
				principal_factor,
				share_indicator,
				contract_size,
				commission
			)
			select
				allocations.account_id,
				allocations.settlement_currency_id,
				allocations.security_id,
				ticket.ticket_type_code,
				case
					when side.buy_indicator = 1
						then 0
						else allocations.quantity
					end,
				ticket.settlement_date,
				currency.exchange_rate,
				side.market_value_sign,
				case
					when coalesce(positions.quantity, 0) = 0
						then allocations.price
						else allocations.price - ((positions.quantity * coalesce(positions.last_mark, positions.unit_cost, 0) + coalesce(#opening_alloc_totals.total_opening_alloc_cost, 0)) / (coalesce(#opening_alloc_totals.total_opening_alloc_quantity, 0) + positions.quantity))
					end,
				security.pricing_factor,
				security.principal_factor,
				side.share_indicator,
				security.contract_size,
				allocations.commission + allocations.taxes + allocations.other_charges + allocations.local_commission + allocations.exchange_fee + allocations.stamp_tax + allocations.levy + allocations.other_taxes_fees
			from 
				#account
				join allocations
					on #account.account_id = allocations.account_id
				join currency
					on allocations.settlement_currency_id = currency.security_id
				join ticket
					on allocations.ticket_id = ticket.ticket_id
				join side
					on allocations.side_code = side.side_code
				join security
					on security.security_id = allocations.security_id
				left outer join positions
					on positions.account_id = allocations.account_id and
					   positions.security_id = allocations.security_id and
					   positions.position_type_code = side.position_type_code
				left outer join #opening_alloc_totals
					on #opening_alloc_totals.account_id = allocations.account_id and
					   #opening_alloc_totals.security_id = allocations.security_id and
					   #opening_alloc_totals.position_type_code = side.position_type_code
			where 
				ticket.settlement_date >= @from_date and
				ticket.settlement_date <= @end_date and
				ticket.ticket_type_code = 7 and
				ticket.deleted = 0 and
				((allocations.primary_confirmed = 1 and allocations.modified = 1) or
				(allocations.primary_pending = 1 and allocations.modified = 0)) and
				allocations.primary_canceled = 0 and
				allocations.deleted = 0 
			option (keepfixed plan);
		end; 
	end; 
	if exists(
		select 1 
		from #user_ccy_mvmt_type 
		where ccy_mvmt_type_code = @confirmed_settle_mvmt
	) begin
		if @ordered_future_flag = 0
		begin
			insert into #driver_gcmr
			(
				account_id,
				currency_code,
				security_id,
				ticket_type_code,
				quantity,
				effective_date,
				currency_exchange_rate,
				multiplier_sign,
				price
			)
			select 
				currency_movement.account_id,
				currency_movement.currency_code,
				currency_movement.security_id,
				currency_movement.ticket_type_code,
				case
					when currency_movement.ticket_type_code in (5, 13)
						 and ticket.settlement_currency_id != coalesce(security.principal_currency_id, -1)
						 and coalesce(ticket.settlement_fx_rate, 0) != 0
					then
						case when coalesce(cross_currency.direction, 1 - cross_currency_inverted.direction, 0) = 0
							then
								round(currency_movement.quantity / ticket.settlement_fx_rate, currency.market_value_rounding)
							else
								round(currency_movement.quantity * ticket.settlement_fx_rate, currency.market_value_rounding)
						end
					else
						currency_movement.quantity
				end,
				currency_movement.effective_date,
				currency.exchange_rate,
				side.market_value_sign,
				1
			from 
				currency_movement
				join #account
					on currency_movement.account_id = #account.account_id
				join side
					on currency_movement.side_code = side.side_code
				join currency
					on currency_movement.currency_code = currency.security_id
				join ticket 
					on currency_movement.ticket_id = ticket.ticket_id
				join security
					on currency_movement.security_id = security.security_id
				left outer join cross_currency
					on security.principal_currency_id = cross_currency.principal_currency_id 
					and ticket.settlement_currency_id = cross_currency.counter_currency_id
				left outer join cross_currency cross_currency_inverted
					on security.principal_currency_id = cross_currency_inverted.counter_currency_id
					and ticket.settlement_currency_id = cross_currency_inverted.principal_currency_id
			where 
				ccy_mvmt_type_code = @confirmed_settle_mvmt and
				currency_movement.ticket_type_code not in (12, 8, 7) and
				currency_movement.primary_canceled = 0 and
				currency_movement.effective_date >= @from_date and
				currency_movement.effective_date <= @end_date and not exists
					(select 1 
					 from allocations 
					 where 
						currency_movement.ticket_id = allocations.ticket_id and
						currency_movement.order_id = allocations.order_id and
						allocations.deleted = 0 and
						((allocations.primary_confirmed = 1 and allocations.modified = 1) or
						(allocations.primary_pending = 1 and allocations.modified = 0))
					)
			option (keepfixed plan);
		end else if @ordered_future_flag = 1 begin
			insert into #driver_gcmr
			(
				account_id,
				currency_code,
				security_id,
				ticket_type_code,
				quantity,
				effective_date,
				currency_exchange_rate,
				multiplier_sign,
				price
			)
			select 
				currency_movement.account_id,
				currency_movement.currency_code,
				currency_movement.security_id,
				currency_movement.ticket_type_code,
				case
					when currency_movement.ticket_type_code = 7 and side.buy_indicator = 1
						then 0
						else 
							case
								when currency_movement.ticket_type_code in (5, 13)
									 and ticket.settlement_currency_id != coalesce(security.principal_currency_id, -1)
									 and coalesce(ticket.settlement_fx_rate, 0) != 0
								then
									case when coalesce(cross_currency.direction, 1 - cross_currency_inverted.direction, 0) = 0
										then
											round(currency_movement.quantity / ticket.settlement_fx_rate, currency.market_value_rounding)
										else
											round(currency_movement.quantity * ticket.settlement_fx_rate, currency.market_value_rounding)
									end
								else
									currency_movement.quantity
							end
					end,
				currency_movement.effective_date,
				currency.exchange_rate,
				side.market_value_sign,
				1
			from 
				currency_movement
				join #account
					on currency_movement.account_id = #account.account_id
				join side
					on currency_movement.side_code = side.side_code
				join currency
					on currency_movement.currency_code = currency.security_id
				join ticket 
					on currency_movement.ticket_id = ticket.ticket_id
				join security
					on currency_movement.security_id = security.security_id
				left outer join cross_currency
					on security.principal_currency_id = cross_currency.principal_currency_id 
					and ticket.settlement_currency_id = cross_currency.counter_currency_id
				left outer join cross_currency cross_currency_inverted
					on security.principal_currency_id = cross_currency_inverted.counter_currency_id
					and ticket.settlement_currency_id = cross_currency_inverted.principal_currency_id
			where 
				ccy_mvmt_type_code = @confirmed_settle_mvmt and
				currency_movement.ticket_type_code not in (12, 8) and
				currency_movement.primary_canceled = 0 and
				currency_movement.effective_date >= @from_date and
				currency_movement.effective_date <= @end_date and not exists
					(select 1 
					from allocations 
					where 
						currency_movement.ticket_id = allocations.ticket_id and
						currency_movement.order_id = allocations.order_id and
						allocations.deleted = 0 and
						((allocations.primary_confirmed = 1 and allocations.modified = 1) or
						(allocations.primary_pending = 1 and allocations.modified = 0)))
			option (keepfixed plan);
		end; 
	end; 
	if exists(
		select 1 
		from #user_ccy_mvmt_type 
		where ccy_mvmt_type_code = @unconfirmed_spot_mvmt
	) begin
		insert into #driver_gcmr
		(
			account_id,
			currency_code,
			security_id,
			ticket_type_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price
		)
		select
			allocations.account_id,
			security.principal_currency_id,
			allocations.security_id,
			ticket.ticket_type_code,
			allocations.quantity,
			ticket.settlement_date,
			currency.exchange_rate,
			side.security_sign,
			1
		from 
			#account,
			allocations,
			currency,
			ticket,
			side,
			security
		where 
			#account.account_id = allocations.account_id and
			allocations.ticket_id = ticket.ticket_id and
			allocations.security_id = security.security_id and
			security.principal_currency_id = currency.security_id and
			ticket.settlement_date >= @from_date and
			ticket.settlement_date <= @end_date and
			ticket.ticket_type_code in (12, 8) and
			allocations.side_code = side.side_code and
			ticket.deleted = 0 and
			allocations.primary_confirmed = 0 and
			allocations.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.primary_pending = 0 
		option (keepfixed plan);
		insert into #driver_gcmr
		(
			account_id,
			currency_code,
			security_id,
			ticket_type_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price
		)
		select
			allocations.account_id,
			allocations.settlement_currency_id,
			allocations.security_id,
			ticket.ticket_type_code,
			allocations.net_amount,
			ticket.settlement_date,
			currency.exchange_rate,
			side.market_value_sign,
			1
		from 
			#account,
			allocations,
			currency,
			ticket,
			side
		where 
			#account.account_id = allocations.account_id and
			allocations.ticket_id = ticket.ticket_id and
			ticket.settlement_date >= @from_date and
			ticket.settlement_date <= @end_date and
			ticket.ticket_type_code in (12, 8) and
			allocations.settlement_currency_id = currency.security_id and
			allocations.side_code = side.side_code and
			ticket.deleted = 0 and
			allocations.primary_confirmed = 0 and
			allocations.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.primary_pending = 0 
		option (keepfixed plan);
		insert into #driver_gcmr
		(
			account_id,
			currency_code,
			security_id,
			ticket_type_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price
		)
		select
			allocations.account_id,
			security.principal_currency_id,
			allocations.security_id,
			ticket.ticket_type_code,
			allocations.quantity,
			ticket.settlement_date,
			currency.exchange_rate,
			side.security_sign,
			1
		from 
			#account,
			allocations,
			currency,
			ticket,
			side,
			security
		where 
			#account.account_id = allocations.account_id and
			allocations.ticket_id = ticket.ticket_id and
			allocations.security_id = security.security_id and
			security.principal_currency_id = currency.security_id and
			ticket.settlement_date >= @from_date and
			ticket.settlement_date <= @end_date and
			ticket.ticket_type_code in (12, 8) and
			allocations.side_code = side.side_code and
			ticket.deleted = 0 and
			((allocations.primary_confirmed = 1 and allocations.modified = 1) or
			(allocations.primary_pending = 1 and allocations.modified = 0)) and
			allocations.primary_canceled = 0 and
			allocations.deleted = 0 
		option (keepfixed plan);
		insert into #driver_gcmr
		(
			account_id,
			currency_code,
			security_id,
			ticket_type_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price
		)
		select
			allocations.account_id,
			allocations.settlement_currency_id,
			allocations.security_id,
			ticket.ticket_type_code,
			allocations.net_amount,
			ticket.settlement_date,
			currency.exchange_rate,
			side.market_value_sign,
			1
		from 
			#account,
			allocations,
			currency,
			ticket,
			side
		where 
			#account.account_id = allocations.account_id and
			allocations.ticket_id = ticket.ticket_id and
			ticket.settlement_date >= @from_date and
			ticket.settlement_date <= @end_date and
			ticket.ticket_type_code in (12, 8) and
			allocations.settlement_currency_id = currency.security_id and
			allocations.side_code = side.side_code and
			ticket.deleted = 0 and
			((allocations.primary_confirmed = 1 and allocations.modified = 1) or
			(allocations.primary_pending = 1 and allocations.modified = 0)) and
			allocations.primary_canceled = 0 and
			allocations.deleted = 0 
		option (keepfixed plan);
	end; 
	if exists(
		select 1 
		from #user_ccy_mvmt_type 
		where ccy_mvmt_type_code = @confirmed_spot_mvmt
	) begin
		insert into #driver_gcmr
		(
			account_id,
			currency_code,
			security_id,
			ticket_type_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price
		)
		select 
			currency_movement.account_id,
			security.principal_currency_id,
			currency_movement.security_id,
			currency_movement.ticket_type_code,
			currency_movement.alloc_qty,
			currency_movement.effective_date,
			currency.exchange_rate,
			side.security_sign,
			1
		from 
			currency_movement,
			#account,
			security,
			side,
			currency
		where 
			currency_movement.security_id = security.security_id and
			currency_movement.account_id = #account.account_id and
			currency_movement.side_code = side.side_code and
			security.principal_currency_id = currency.security_id and
			currency_movement.ticket_type_code in (12, 8) and
			currency_movement.primary_canceled = 0 and
			currency_movement.effective_date >= @from_date and
			currency_movement.effective_date <= @end_date and not exists
				(select 1 
				from allocations 
				where 
					currency_movement.ticket_id = allocations.ticket_id and
					currency_movement.order_id = allocations.order_id and
					allocations.deleted = 0 and
					((allocations.primary_confirmed = 1 and allocations.modified = 1) or
					(allocations.primary_pending = 1 and allocations.modified = 0)))
		option (keepfixed plan);
		insert into #driver_gcmr
		(
			account_id,
			currency_code,
			security_id,
			ticket_type_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price
		)
		select
			currency_movement.account_id,
			currency_movement.currency_code,
			currency_movement.security_id,
			currency_movement.ticket_type_code,
			currency_movement.quantity,
			currency_movement.effective_date,
			currency.exchange_rate,
			side.market_value_sign,
			1
		from 
			currency_movement,
			#account,
			side,
			currency
		where 
			currency_movement.currency_code = currency.security_id and
			currency_movement.account_id = #account.account_id and
			currency_movement.side_code = side.side_code and
			currency_movement.ticket_type_code in (12, 8) and
			currency_movement.primary_canceled = 0 and
			currency_movement.effective_date >= @from_date and
			currency_movement.effective_date <= @end_date and not exists
				(select 1 
				 from allocations 
				 where 
					currency_movement.ticket_id = allocations.ticket_id and
					currency_movement.order_id = allocations.order_id and
					allocations.deleted = 0 and
					((allocations.primary_confirmed = 1 and allocations.modified = 1) or
					(allocations.primary_pending = 1 and allocations.modified = 0))
				)
		option (keepfixed plan);
	end; 
	if @ordered_equity_flag = 1
	begin
		insert into #alloc_qty_gcmr 
		(
			order_id, 
			allocations_qty,
			ticket_type_code,
			principal_currency_id,
			side_code
		)
		select 
			orders.order_id,
			case
				when side.share_indicator = 1
					then coalesce(sum(allocations.quantity), 0)
				else coalesce(sum(allocations.net_amount), 0)
				end,
			1,
			security.principal_currency_id,
			allocations.side_code
		from 
			allocations,
			#account,
			orders,
			security,
			currency,
			side
		where 	
			orders.account_id = #account.account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 1 and
			security.principal_currency_id = currency.security_id and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0 and
			allocations.side_code = side.side_code
		group by 
			orders.order_id,
			allocations.side_code,
			security.principal_currency_id,
			side.share_indicator
		option (keepfixed plan);
		insert into #ordered_driver_ccy
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			currency_exchange_rate,
			multiplier_sign,
			price,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date,
			share_indicator
		)
		select 
			orders.account_id,
			security.security_id,
			coalesce(exchange.country_code, security.country_code),
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then sum(orders.quantity - orders.quantity_closed - coalesce(#alloc_qty_gcmr.allocations_qty, 0))
				else sum(case 
							when orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmr.allocations_qty / currency.exchange_rate, 0)> 0
								then orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmr.allocations_qty / currency.exchange_rate, 0)
							else 0
							end)
				end,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			orders.settlement_date,
			side.share_indicator
		from
			orders
			join #account on orders.account_id = #account.account_id
			join security on orders.security_id = security.security_id
			join currency on security.principal_currency_id = currency.security_id
			join side on orders.side_code = side.side_code
			join price on security.security_id = price.security_id
			left outer join exchange on security.exchange_code = exchange.exchange_code
			left outer join #alloc_qty_gcmr
				on orders.order_id = #alloc_qty_gcmr.order_id 
				and security.principal_currency_id = #alloc_qty_gcmr.principal_currency_id 
				and orders.ticket_type_code = #alloc_qty_gcmr.ticket_type_code 
				and orders.side_code = #alloc_qty_gcmr.side_code
				and #alloc_qty_gcmr.allocations_qty <> 0
		where
			orders.ticket_type_code = 1 and
			orders.deleted = 0 and
			security.deleted = 0
		group by
			orders.account_id,
			security.security_id,
			coalesce(exchange.country_code, security.country_code),
			security.principal_currency_id,
			orders.market_value,
			orders.market_value_closed,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			orders.settlement_date,
			#alloc_qty_gcmr.allocations_qty,
			side.share_indicator
		option (keepfixed plan);
	end; 
	if @ordered_equity_ipo_flag = 1
	begin
		insert into #alloc_qty_gcmr 
		(
			order_id, 
			allocations_qty,
			ticket_type_code,
			principal_currency_id,
			side_code
		)
		select 
			orders.order_id,
			case
				when side.share_indicator = 1
					then coalesce(sum(allocations.quantity), 0)
				else coalesce(sum(allocations.net_amount), 0)
				end,
			2,
			security.principal_currency_id,
			allocations.side_code
		from 
			allocations,
			#account,
			orders,
			security,
			currency,
			side
		where 
			orders.account_id = #account.account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 2 and
			security.principal_currency_id = currency.security_id and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0 and
			allocations.side_code = side.side_code
		group by 
			orders.order_id,
			allocations.side_code,
			security.principal_currency_id,
			side.share_indicator
		option (keepfixed plan);
		insert into #ordered_driver_ccy
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			currency_exchange_rate,
			multiplier_sign,
			price,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date,
			share_indicator
		)
		select 
			orders.account_id,
			security.security_id,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then sum(orders.quantity - orders.quantity_closed - coalesce(#alloc_qty_gcmr.allocations_qty, 0))
				else sum(case 
							when orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmr.allocations_qty / currency.exchange_rate, 0)> 0
								then orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmr.allocations_qty / currency.exchange_rate, 0)
							else 0
							end)
				end,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			orders.settlement_date,
			side.share_indicator
		from
			orders
			join #account on orders.account_id = #account.account_id
			join security on orders.security_id = security.security_id
			join currency on security.principal_currency_id = currency.security_id
			join side on orders.side_code = side.side_code
			join price on security.security_id = price.security_id
			join exchange on security.exchange_code = exchange.exchange_code
			left outer join #alloc_qty_gcmr
                 on orders.order_id = #alloc_qty_gcmr.order_id and 
                    orders.ticket_type_code = #alloc_qty_gcmr.ticket_type_code and 
                    orders.side_code = #alloc_qty_gcmr.side_code and 
                    security.principal_currency_id = #alloc_qty_gcmr.principal_currency_id
		where
			orders.ticket_type_code = 2 and
			orders.deleted = 0 and
			security.deleted = 0
		group by
			orders.account_id,
			security.security_id,
			exchange.country_code,
			security.principal_currency_id,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			orders.settlement_date,
			#alloc_qty_gcmr.allocations_qty,
			side.share_indicator
		option (keepfixed plan);
	end; 
	if @ordered_eqty_sec_off_flag = 1
	begin
		insert into #alloc_qty_gcmr 
		(
			order_id, 
			allocations_qty,
			ticket_type_code,
			principal_currency_id,
			side_code
		)
		select 
			orders.order_id,
			case
				when side.share_indicator = 1
					then coalesce(sum(allocations.quantity), 0)
				else coalesce(sum(allocations.net_amount), 0)
				end,
			3,
			security.principal_currency_id,
			allocations.side_code
		from 
			allocations,
			#account,
			orders,
			security,
			currency,
			side
		where 	
			orders.account_id = #account.account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 3 and
			security.principal_currency_id = currency.security_id and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0 and
			allocations.side_code = side.side_code
		group by 
			orders.order_id,
			allocations.side_code,
			security.principal_currency_id,
			side.share_indicator
		option (keepfixed plan);
		insert into #ordered_driver_ccy
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			currency_exchange_rate,
			multiplier_sign,
			price,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date,
			share_indicator
		)
		select 
			orders.account_id,
			security.security_id,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then sum(orders.quantity - orders.quantity_closed - coalesce(#alloc_qty_gcmr.allocations_qty, 0))
				else sum(case 
							when orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmr.allocations_qty / currency.exchange_rate, 0)> 0
								then orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmr.allocations_qty / currency.exchange_rate, 0)
							else 0
							end)
				end,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			orders.settlement_date,
			side.share_indicator
		from
			orders
			join #account on orders.account_id = #account.account_id
			join security on orders.security_id = security.security_id
			join currency on security.principal_currency_id = currency.security_id
			join side on orders.side_code = side.side_code
			join price on security.security_id = price.security_id
			join exchange on security.exchange_code = exchange.exchange_code
			left outer join #alloc_qty_gcmr on orders.order_id = #alloc_qty_gcmr.order_id and orders.ticket_type_code = #alloc_qty_gcmr.ticket_type_code and orders.side_code = #alloc_qty_gcmr.side_code and security.principal_currency_id = #alloc_qty_gcmr.principal_currency_id
		where
			orders.ticket_type_code = 3 and
			orders.deleted = 0 and
			security.deleted = 0
		group by
			orders.account_id,
			security.security_id,
			exchange.country_code,
			security.principal_currency_id,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			orders.settlement_date,
			#alloc_qty_gcmr.allocations_qty,
			side.share_indicator
		option (keepfixed plan);
	end; 
	if @ordered_debt_flag = 1
	begin
		insert into #alloc_qty_gcmr 
		(
			order_id, 
			allocations_qty,
			ticket_type_code,
			principal_currency_id,
			side_code
		)
		select 
			orders.order_id,
			case
				when side.share_indicator = 1
					then coalesce(sum(allocations.quantity), 0)
				else coalesce(sum(allocations.net_amount), 0)
				end,
			orders.ticket_type_code,
			security.principal_currency_id,
			allocations.side_code
		from 
			allocations,
			#account,
			orders,
			security,
			currency,
			side
		where 
			orders.account_id = #account.account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
	    	orders.ticket_type_code in (5, 13) and
			orders.settlement_date >= @from_date and
			orders.settlement_date <= @end_date and
			security.principal_currency_id = currency.security_id and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0 and
			allocations.side_code = side.side_code
		group by orders.order_id,
			allocations.side_code,
			security.principal_currency_id,
			orders.ticket_type_code,
			side.share_indicator
		option (keepfixed plan);
		insert into #driver_gcmr
		(
			account_id,
			currency_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price,
			pricing_factor,
			principal_factor,
			accrued_income,
			mkt_val_display_curr,
			share_indicator
		)
		select 
			orders.account_id,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then sum(orders.quantity - orders.quantity_closed - coalesce(#alloc_qty_gcmr.allocations_qty, 0))
				else sum(case 
							when orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmr.allocations_qty / currency.exchange_rate, 0)> 0
								then orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmr.allocations_qty / currency.exchange_rate, 0)
							else 0
							end)
				end,
			orders.settlement_date,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			case
				when side.share_indicator = 1
				then sum(case
						when orders.quantity <> 0
						then ((orders.quantity - orders.quantity_closed - coalesce(#alloc_qty_gcmr.allocations_qty, 0)) 
						/ orders.quantity)
						* orders.accrued_income
						else 0
						end)
				else sum(case 
					when orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmr.allocations_qty / currency.exchange_rate, 0)> 0
						and orders.market_value <> 0
						then ((orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmr.allocations_qty / currency.exchange_rate, 0))
						 / orders.market_value) 
						 * orders.accrued_income
					else 0
					end)
			end,
			case
				when side.share_indicator = 0
					then sum(side.market_value_sign 
					* ((orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmr.allocations_qty / currency.exchange_rate, 0))
					* @display_exchange_rate)) 
				end,
			side.share_indicator
		from
			orders
			join #account 
				on orders.account_id = #account.account_id
			join security 
				on orders.security_id = security.security_id
			join currency 
				on security.principal_currency_id = currency.security_id
			join side 
				on orders.side_code = side.side_code
			join price 
				on security.security_id = price.security_id
			left outer join #alloc_qty_gcmr 
				on orders.order_id = #alloc_qty_gcmr.order_id and 
					orders.ticket_type_code = #alloc_qty_gcmr.ticket_type_code and 
					orders.side_code = #alloc_qty_gcmr.side_code and 
					security.principal_currency_id = #alloc_qty_gcmr.principal_currency_id
		where
			orders.settlement_date >= @from_date and
			orders.settlement_date <= @end_date and
			orders.ticket_type_code in (5, 13) and
			orders.deleted = 0 and
			security.deleted = 0
		group by
			orders.account_id,
			security.principal_currency_id,
			orders.settlement_date,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			#alloc_qty_gcmr.allocations_qty,
			orders.market_value,
			side.share_indicator
		option (keepfixed plan);
	end; 
	if @ordered_fund_flag = 1
	begin
		insert into #alloc_qty_gcmr 
		(
			order_id, 
			allocations_qty,
			ticket_type_code,
			principal_currency_id,
			side_code
		)
		select 
			orders.order_id,
			case
				when side.share_indicator = 1
					then coalesce(sum(allocations.quantity), 0)
				else coalesce(sum(allocations.net_amount), 0)
				end,
			6,
			security.principal_currency_id,
			allocations.side_code
		from 
			allocations,
		    #account,
			orders,
			security,
			currency,
			side
		where
			orders.account_id = #account.account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 6 and
			security.principal_currency_id = currency.security_id and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0 and
			allocations.side_code = side.side_code
		group by 
		 	orders.order_id,
			allocations.side_code,
			security.principal_currency_id,
			side.share_indicator
		 option (keepfixed plan);
		insert into #ordered_driver_ccy
		(
			account_id,
			security_id,
			order_id,
			exchange_country_code,
			currency_code,
			quantity,
			currency_exchange_rate,
			multiplier_sign,
			price,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date,
			share_indicator
		)
		select 
			orders.account_id,
			security.security_id,
			orders.order_id,
			coalesce(exchange.country_code, security.country_code ),
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then sum(orders.quantity - orders.quantity_closed - coalesce(#alloc_qty_gcmr.allocations_qty, 0))
				else sum(case 
							when orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmr.allocations_qty / currency.exchange_rate, 0)> 0
								then orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmr.allocations_qty / currency.exchange_rate, 0)
							else 0
							end)
				end,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			orders.settlement_date,
			side.share_indicator
		from orders
		join #account 
			on orders.account_id = #account.account_id
		join security 
			on orders.security_id = security.security_id
		join currency 
			on security.principal_currency_id = currency.security_id
		join side 
			on orders.side_code = side.side_code
		join price 
			on security.security_id = price.security_id
		left outer join exchange 
			on security.exchange_code = exchange.exchange_code
		left outer join #alloc_qty_gcmr 
			on orders.order_id = #alloc_qty_gcmr.order_id 
			and orders.ticket_type_code = #alloc_qty_gcmr.ticket_type_code 
			and orders.side_code = #alloc_qty_gcmr.side_code 
			and security.principal_currency_id = #alloc_qty_gcmr.principal_currency_id
		where
			orders.ticket_type_code = 6 and
			orders.deleted = 0 and
			security.deleted = 0
		group by
			orders.account_id,
			security.security_id,
			orders.order_id,
			coalesce(exchange.country_code, security.country_code ),
			security.principal_currency_id,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			orders.accrued_income,
			orders.settlement_date,
			#alloc_qty_gcmr.allocations_qty,
			side.share_indicator
		option (keepfixed plan);
	end; 
	insert into #ordered_settle_date_driver
	(
		order_id,
		security_id,
		exchange_country_code
	)
	select distinct
		#ordered_driver_ccy.order_id,
		#ordered_driver_ccy.security_id,
		#ordered_driver_ccy.exchange_country_code
	from #ordered_driver_ccy
	join orders
		on orders.order_id = #ordered_driver_ccy.order_id
	where orders.ticket_type_code = 6
		and orders.deleted = 0
		and #ordered_driver_ccy.effective_date is null
	option (keepfixed plan);
	while exists(
		select 1
		from #ordered_settle_date_driver
	) begin
		select @order_id = min(order_id)
		from  #ordered_settle_date_driver;
		select 
			@exchange_country_code = exchange_country_code,
			@security_id = security_id
		from #ordered_settle_date_driver
		where order_id = @order_id;
		select @trade_date = trade_date
		from orders 
		where order_id = @order_id;
		select @exchange_code = exchange_code,
			@major_asset_code = major_asset_code,
			@minor_asset_code = minor_asset_code,
			@bond_type_code = bond_type_code,
			@issuer_type_code = issuer_type_code,
			@delivery_code = delivery_code
		from security
		where security_id = @security_id;
		execute @ret_val = get_next_valid_business_day 
										@valid_business_date = @trade_date output,
										@country_code = @exchange_country_code,
										@exchange_code = @exchange_code,
										@major_asset_code = @major_asset_code,
										@minor_asset_code = @minor_asset_code,
										@bond_type_code = @bond_type_code,
										@issuer_type_code = @issuer_type_code,
										@delivery_code = @delivery_code
										;
		execute @ret_val = get_settlement_days  @calendar_days = @offset output, @country_code = @exchange_country_code, @security_id = @security_id, @trade_date = @trade_date;
		select @settlement_date = dateadd(dd, @offset, @trade_date);
		execute @ret_val = valid_settle_day 
										@valid_settle_day = @valid_settle_day output,
										@country_code = @exchange_country_code,
										@dated = @settlement_date,
										@exchange_code = @exchange_code,
										@major_asset_code = @major_asset_code,
										@minor_asset_code = @minor_asset_code,
										@bond_type_code = @bond_type_code,
										@issuer_type_code = @issuer_type_code,
										@delivery_code = @delivery_code
										;
		if @valid_settle_day = 0
		begin
			while @valid_settle_day = 0
			begin
				select @settlement_date = dateadd(dd, 1, @settlement_date);
				execute @ret_val = valid_settle_day 
										@valid_settle_day = @valid_settle_day output,
										@country_code = @exchange_country_code,
										@dated = @settlement_date,
										@exchange_code = @exchange_code,
										@major_asset_code = @major_asset_code,
										@minor_asset_code = @minor_asset_code,
										@bond_type_code = @bond_type_code,
										@issuer_type_code = @issuer_type_code,
										@delivery_code = @delivery_code
										;
			end; 
		end;
		if @valid_settle_day = 1
		begin
			update #ordered_driver_ccy
			set effective_date = @settlement_date
			where order_id = @order_id;
		end;
		delete from #ordered_settle_date_driver
		where order_id = @order_id;
	end;  
	if @ordered_future_flag = 1
	begin
		insert into #alloc_qty_gcmr 
		(
			order_id, 
			allocations_qty,
			ticket_type_code,
			principal_currency_id,
			side_code
		)
		select 
			orders.order_id,
			case
				when side.buy_indicator = 1
					then 0
				when side.share_indicator = 1
					then coalesce(sum(allocations.quantity), 0)
				else coalesce(sum(allocations.net_amount), 0)
				end,
			7,
			security.principal_currency_id,
			allocations.side_code
		from 
			allocations,
			#account,
			orders,
			security,
			currency,
			side
		where 	
			orders.account_id = #account.account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 7 and
			security.principal_currency_id = currency.security_id and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0 and
			allocations.side_code = side.side_code
		group by 
			orders.order_id,
			allocations.side_code,
			security.principal_currency_id,
			side.share_indicator,
			side.buy_indicator
		option (keepfixed plan);
		insert into #ordered_driver_ccy
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			currency_exchange_rate,
			multiplier_sign,
			price,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date,
			share_indicator,
			contract_size
		)
		select 
			orders.account_id,
			security.security_id,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.buy_indicator = 1
					then 0
				when side.share_indicator = 1
					then sum(orders.quantity - orders.quantity_closed - coalesce(#alloc_qty_gcmr.allocations_qty, 0))
				else sum(case 
							when orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmr.allocations_qty / currency.exchange_rate, 0)> 0
								then orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmr.allocations_qty / currency.exchange_rate, 0)
							else 0
							end)
				end,
			currency.exchange_rate,
			side.market_value_sign,
			case
				when positions.last_mark is not null
					then price.latest - positions.last_mark
				when positions.unit_cost is not null
					then price.latest - positions.unit_cost
				else price.latest
				end,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			orders.settlement_date,
			side.share_indicator,
			security.contract_size
		from orders
		join #account 
			on orders.account_id = #account.account_id
		join security 
			on orders.security_id = security.security_id
		join currency 
			on security.principal_currency_id = currency.security_id
		join side 
			on orders.side_code = side.side_code
		join price 
			on security.security_id = price.security_id
		join exchange 
			on security.exchange_code = exchange.exchange_code
		left outer join positions
			on positions.account_id = #account.account_id
			and positions.security_id = security.security_id
			and positions.position_type_code = side.position_type_code
		left outer join #alloc_qty_gcmr 
			on orders.order_id = #alloc_qty_gcmr.order_id 
			and orders.ticket_type_code = #alloc_qty_gcmr.ticket_type_code 
			and orders.side_code = #alloc_qty_gcmr.side_code 
			and security.principal_currency_id = #alloc_qty_gcmr.principal_currency_id
		where
			orders.ticket_type_code = 7 and
			orders.deleted = 0 and
			security.deleted = 0
		group by
			orders.account_id,
			security.security_id,
			exchange.country_code,
			security.principal_currency_id,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			orders.settlement_date,
			#alloc_qty_gcmr.allocations_qty,
			side.share_indicator,
			side.buy_indicator,
			security.contract_size,
			positions.last_mark,
			positions.unit_cost
		option (keepfixed plan);
	end; 
	if @ordered_forward_flag = 1
	begin
		insert into #alloc_qty_gcmr 
		(
			order_id, 
			allocations_qty,
			ticket_type_code,
			principal_currency_id,
			side_code
		)
		select 
			orders.order_id,
			coalesce(sum(allocations.quantity), 0),
			8,
			security.principal_currency_id,
			allocations.side_code
		from 
			allocations,
			#account,
			orders,
			security,
			currency
		where 	
			orders.account_id = #account.account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 8 and
			orders.settlement_date >= @from_date and
			orders.settlement_date <= @end_date and
			security.principal_currency_id = currency.security_id and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0
		group by 
			orders.order_id,
			allocations.side_code,
			security.principal_currency_id
		option (keepfixed plan);
		insert into #driver_gcmr
		(
			account_id,
			currency_code,
			security_id,
			ticket_type_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price
		)
		select 
			orders.account_id,
			security.principal_currency_id,
			security.security_id,
			orders.ticket_type_code,
			sum(orders.quantity - orders.quantity_closed - coalesce(#alloc_qty_gcmr.allocations_qty, 0)),
			orders.settlement_date,
			currency.exchange_rate,
			side.security_sign,
			1
		from
			orders
			join #account on orders.account_id = #account.account_id
			join security on orders.security_id = security.security_id
			join currency on security.principal_currency_id = currency.security_id
			join side on orders.side_code = side.side_code
			left outer join #alloc_qty_gcmr on orders.order_id = #alloc_qty_gcmr.order_id and orders.ticket_type_code = #alloc_qty_gcmr.ticket_type_code and orders.side_code = #alloc_qty_gcmr.side_code and security.principal_currency_id = #alloc_qty_gcmr.principal_currency_id
		where
			orders.settlement_date >= @from_date and
			orders.settlement_date <= @end_date and
			orders.ticket_type_code = 8 and
			orders.deleted = 0 and
			security.deleted = 0
		group by
			orders.account_id,
			security.principal_currency_id,
			security.security_id,
			orders.ticket_type_code,
			orders.settlement_date,
			currency.exchange_rate,
			side.security_sign,
			#alloc_qty_gcmr.allocations_qty
		option (keepfixed plan);
		delete from #alloc_qty_gcmr 
		where ticket_type_code = 8 
		option (keepfixed plan);
		insert into #alloc_qty_gcmr 
		(
			order_id, 
			allocations_qty,
			ticket_type_code,
			principal_currency_id,
			side_code
		)
		select 
			orders.order_id,
			coalesce(sum(allocations.quantity), 0),
			8,
			security.settlement_currency_id,
			allocations.side_code
		from 
			allocations,
			#account,
			orders,
			security,
			currency
		where 
			orders.account_id = #account.account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 8 and
			orders.settlement_date >= @from_date and
			orders.settlement_date <= @end_date and
			security.settlement_currency_id = currency.security_id and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0
		group by 
			orders.order_id,
			allocations.side_code,
			security.settlement_currency_id
		option (keepfixed plan);
		insert into #driver_gcmr
		(
			account_id,
			currency_code,
			security_id,
			ticket_type_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price
		)
		select 
			orders.account_id,
			security.settlement_currency_id,
			orders.security_id,
			orders.ticket_type_code,
			sum(orders.quantity - orders.quantity_closed - coalesce(#alloc_qty_gcmr.allocations_qty, 0)),
			orders.settlement_date,
			currency.exchange_rate,
			side.market_value_sign,
			null
		from orders
		join #account 
			on orders.account_id = #account.account_id
		join security 
			on orders.security_id = security.security_id
		join currency 
			on security.settlement_currency_id = currency.security_id
		join side 
			on orders.side_code = side.side_code
		left outer join #alloc_qty_gcmr 
			on orders.order_id = #alloc_qty_gcmr.order_id 
			and orders.ticket_type_code = #alloc_qty_gcmr.ticket_type_code 
			and orders.side_code = #alloc_qty_gcmr.side_code 
			and security.settlement_currency_id = #alloc_qty_gcmr.principal_currency_id
		where
			orders.settlement_date >= @from_date and
			orders.settlement_date <= @end_date and
			orders.ticket_type_code = 8 and
			orders.deleted = 0 and
			security.deleted = 0
		group by
			orders.account_id,
			security.settlement_currency_id,
			orders.security_id,
			orders.ticket_type_code,
			orders.settlement_date,
			currency.exchange_rate,
			side.market_value_sign,
			#alloc_qty_gcmr.allocations_qty
		option (keepfixed plan);
	end; 
	if @ordered_option_flag = 1
	begin
		insert into #alloc_qty_gcmr 
		(
			order_id, 
			allocations_qty,
			ticket_type_code,
			principal_currency_id,
			side_code
		)
		select 
			orders.order_id,
			coalesce(sum(allocations.quantity), 0),
			9,
			security.principal_currency_id,
			allocations.side_code
		from 
			allocations,
			#account,
			orders,
			security,
			currency
		where
			orders.account_id = #account.account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 9 and
			security.principal_currency_id = currency.security_id and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0
		group by 
			orders.order_id,
			allocations.side_code,
			security.principal_currency_id
		option (keepfixed plan);
		insert into #ordered_driver_ccy
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			currency_exchange_rate,
			multiplier_sign,
			price,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date
		)
		select 
			orders.account_id,
			security.security_id,
			exchange.country_code,
			security.principal_currency_id,
			sum(orders.quantity - orders.quantity_closed - coalesce(#alloc_qty_gcmr.allocations_qty, 0)),
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			orders.settlement_date
		from orders
		join #account 
			on orders.account_id = #account.account_id
		join security 
			on orders.security_id = security.security_id
		join currency 
			on security.principal_currency_id = currency.security_id
		join side 
			on orders.side_code = side.side_code
		join price 
			on security.security_id = price.security_id
		join exchange 
			on security.exchange_code = exchange.exchange_code
		left outer join #alloc_qty_gcmr 
			on orders.order_id = #alloc_qty_gcmr.order_id 
			and orders.ticket_type_code = #alloc_qty_gcmr.ticket_type_code 
			and orders.side_code = #alloc_qty_gcmr.side_code 
			and security.principal_currency_id = #alloc_qty_gcmr.principal_currency_id
		where
			orders.ticket_type_code = 9 and
			orders.deleted = 0 and
			security.deleted = 0
		group by
			orders.account_id,
			security.security_id,
			exchange.country_code,
			security.principal_currency_id,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			orders.settlement_date,
			#alloc_qty_gcmr.allocations_qty
		option (keepfixed plan);
	end; 
	if @ordered_index_flag = 1
	begin
		insert into #alloc_qty_gcmr 
		(
			order_id, 
			allocations_qty,
			ticket_type_code,
			principal_currency_id,
			side_code
		)
		select 
			orders.order_id,
			case
				when side.share_indicator = 1
					then coalesce(sum(allocations.quantity), 0)
				else coalesce(sum(allocations.net_amount), 0)
				end,
			10,
			security.principal_currency_id,
			allocations.side_code
		from 
			allocations,
			#account,
			orders,
			security,
			currency,
			side
		where 	
			orders.account_id = #account.account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 10 and
			security.principal_currency_id = currency.security_id and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0 and
			allocations.side_code = side.side_code
		group by 
			orders.order_id,
			allocations.side_code,
			security.principal_currency_id,
			side.share_indicator
		option (keepfixed plan);
		insert into #ordered_driver_ccy
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			currency_exchange_rate,
			multiplier_sign,
			price,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date,
			share_indicator
		)
		select 
			orders.account_id,
			security.security_id,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then sum(orders.quantity - orders.quantity_closed - coalesce(#alloc_qty_gcmr.allocations_qty, 0))
				else sum(case 
							when orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmr.allocations_qty / currency.exchange_rate, 0)> 0
								then orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmr.allocations_qty / currency.exchange_rate, 0)
							else 0
							end)
				end,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			orders.settlement_date,
			side.share_indicator
		from orders
		join #account 
			on orders.account_id = #account.account_id
		join security 
			on orders.security_id = security.security_id
		join currency 
			on security.principal_currency_id = currency.security_id
		join side 
			on orders.side_code = side.side_code
		join price 
			on security.security_id = price.security_id
		join exchange 
			on security.exchange_code = exchange.exchange_code
		left outer join #alloc_qty_gcmr 
			on orders.order_id = #alloc_qty_gcmr.order_id 
			and orders.ticket_type_code = #alloc_qty_gcmr.ticket_type_code 
			and orders.side_code = #alloc_qty_gcmr.side_code 
			and security.principal_currency_id = #alloc_qty_gcmr.principal_currency_id
		where
			orders.ticket_type_code = 10 and
			orders.deleted = 0 and
			security.deleted = 0
		group by
			orders.account_id,
			security.security_id,
			exchange.country_code,
			security.principal_currency_id,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			orders.settlement_date,
			#alloc_qty_gcmr.allocations_qty,
			side.share_indicator
		option (keepfixed plan);
	end; 
	if @ordered_unclassified_flag = 1
	begin
		insert into #alloc_qty_gcmr 
		(
			order_id, 
			allocations_qty,
			ticket_type_code,
			principal_currency_id,
			side_code
		)
		select 
			orders.order_id,
			case
				when side.share_indicator = 1
					then coalesce(sum(allocations.quantity), 0)
				else coalesce(sum(allocations.net_amount), 0)
				end,
			11,
			security.principal_currency_id,
			allocations.side_code
		from 
			allocations,
		    #account,
			orders,
			security,
			currency,
			side
		where
			orders.account_id = #account.account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 11 and
			security.principal_currency_id = currency.security_id and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0 and
			allocations.side_code = side.side_code
		group by 
			orders.order_id,
			allocations.side_code,
			security.principal_currency_id,
			side.share_indicator
		 option (keepfixed plan);
		insert into #ordered_driver_ccy
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			currency_exchange_rate,
			multiplier_sign,
			price,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date,
			share_indicator,
			contract_size
		)
		select 
			orders.account_id,
			security.security_id,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then sum(orders.quantity - orders.quantity_closed - coalesce(#alloc_qty_gcmr.allocations_qty, 0))
				else sum(case 
							when orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmr.allocations_qty / currency.exchange_rate, 0)> 0
								then orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmr.allocations_qty / currency.exchange_rate, 0)
							else 0
							end)
				end,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			orders.settlement_date,
			side.share_indicator,
			security.contract_size
		from orders
		join #account 
			on orders.account_id = #account.account_id
		join security 
			on orders.security_id = security.security_id
		join currency 
			on security.principal_currency_id = currency.security_id
		join side 
			on orders.side_code = side.side_code
		join price 
			on security.security_id = price.security_id
		join exchange 
			on security.exchange_code = exchange.exchange_code
		left outer join #alloc_qty_gcmr 
			on orders.order_id = #alloc_qty_gcmr.order_id 
			and orders.ticket_type_code = #alloc_qty_gcmr.ticket_type_code 
			and orders.side_code = #alloc_qty_gcmr.side_code 
			and security.principal_currency_id = #alloc_qty_gcmr.principal_currency_id
		where
			orders.ticket_type_code = 11 and
			orders.deleted = 0 and
			security.deleted = 0
		group by
			orders.account_id,
			security.security_id,
			exchange.country_code,
			security.principal_currency_id,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			orders.settlement_date,
			#alloc_qty_gcmr.allocations_qty,
			side.share_indicator,
			security.contract_size
		option (keepfixed plan);
	end; 
	if @ordered_spot_flag = 1
	begin
		insert into #alloc_qty_gcmr 
		(
			order_id, 
			allocations_qty,
			ticket_type_code,
			principal_currency_id,
			side_code
		)
		select 
			orders.order_id,
			coalesce(sum(allocations.quantity), 0),
			12,
			security.principal_currency_id,
			allocations.side_code
		from 
			allocations,
			#account,
			orders,
			security,
			currency
		where 
			orders.account_id = #account.account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 12 and
			orders.settlement_date >= @from_date and
			orders.settlement_date <= @end_date and
			security.principal_currency_id = currency.security_id and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0
		group by 
		 	orders.order_id,
			allocations.side_code,
			security.principal_currency_id
		 option (keepfixed plan);
		insert into #driver_gcmr
		(
			account_id,
			currency_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price
		)
		select 
			orders.account_id,
			security.principal_currency_id,
			sum(orders.quantity - orders.quantity_closed - coalesce(#alloc_qty_gcmr.allocations_qty, 0)),
			orders.settlement_date,
			currency.exchange_rate,
			side.security_sign,
			1
		from orders
		join #account 
			on orders.account_id = #account.account_id
		join security 
			on orders.security_id = security.security_id
		join currency 
			on security.principal_currency_id = currency.security_id
		join side 
			on orders.side_code = side.side_code
		left outer join #alloc_qty_gcmr 
			on orders.order_id = #alloc_qty_gcmr.order_id 
			and orders.ticket_type_code = #alloc_qty_gcmr.ticket_type_code 
			and orders.side_code = #alloc_qty_gcmr.side_code 
			and security.principal_currency_id = #alloc_qty_gcmr.principal_currency_id
		where
			orders.settlement_date >= @from_date and
			orders.settlement_date <= @end_date and
			orders.ticket_type_code = 12 and
			orders.deleted = 0 and
			security.deleted = 0
		group by
			orders.account_id,
			security.principal_currency_id,
			orders.settlement_date,
			currency.exchange_rate,
			side.security_sign,
			#alloc_qty_gcmr.allocations_qty
		option (keepfixed plan);
		delete from #alloc_qty_gcmr 
		where ticket_type_code = 12
		option (keepfixed plan);
		insert into #alloc_qty_gcmr 
		(
			order_id, 
			allocations_qty,
			ticket_type_code,
			principal_currency_id,
			side_code
		)
		select 
			orders.order_id,
			coalesce(sum(allocations.quantity), 0),
			12,
			security.settlement_currency_id,
			allocations.side_code
		from 
			allocations,
			#account,
			orders,
			security,
			currency
		where 	
			orders.account_id = #account.account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 12 and
			orders.settlement_date >= @from_date and
			orders.settlement_date <= @end_date and
			security.settlement_currency_id = currency.security_id and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0
		group by 
			orders.order_id,
			allocations.side_code,
			security.settlement_currency_id
		option (keepfixed plan);
		insert into #driver_gcmr
		(
			account_id,
			currency_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price
		)
		select 
			orders.account_id,
			security.settlement_currency_id,
			sum(orders.quantity - orders.quantity_closed - coalesce(#alloc_qty_gcmr.allocations_qty, 0)),
			orders.settlement_date,
			currency.exchange_rate,
			side.market_value_sign, 
			price.latest
		from orders
		join #account 
			on orders.account_id = #account.account_id
		join security 
			on orders.security_id = security.security_id
		join currency 
			on security.settlement_currency_id = currency.security_id
		join side 
			on orders.side_code = side.side_code
		join price 
			on security.security_id = price.security_id
		left outer join #alloc_qty_gcmr 
			on orders.order_id = #alloc_qty_gcmr.order_id 
			and orders.ticket_type_code = #alloc_qty_gcmr.ticket_type_code 
			and orders.side_code = #alloc_qty_gcmr.side_code 
			and security.settlement_currency_id = #alloc_qty_gcmr.principal_currency_id
		where
			orders.settlement_date >= @from_date and
			orders.settlement_date <= @end_date and
			orders.ticket_type_code = 12 and
			orders.deleted = 0 and
			security.deleted = 0
		group by
			orders.account_id,
			security.settlement_currency_id,
			orders.settlement_date,
			currency.exchange_rate,
			side.market_value_sign, 
			price.latest,
			#alloc_qty_gcmr.allocations_qty
		option (keepfixed plan);
	end; 
	if @ordered_equity_flag = 1 
		or @ordered_equity_ipo_flag = 1 
		or @ordered_eqty_sec_off_flag = 1
		or @ordered_future_flag = 1
		or @ordered_option_flag = 1 
		or @ordered_index_flag = 1 
		or @ordered_unclassified_flag = 1
	begin
		insert into #ordered_settle_date_driver 
		(
			security_id,
			exchange_country_code
		)
		select distinct
			security_id,
			exchange_country_code
		from 
			#ordered_driver_ccy
		where 
			effective_date is null
		option (keepfixed plan);
		select @trade_date = @current_date;
		while exists(
			select 1
			from #ordered_settle_date_driver
		) begin
			select @security_id = min(security_id) 
			from  #ordered_settle_date_driver;
			select @exchange_country_code = exchange_country_code 
			from #ordered_settle_date_driver
			where security_id = @security_id;
			select @exchange_code = exchange_code,
				@major_asset_code = major_asset_code,
				@minor_asset_code = minor_asset_code,
				@bond_type_code = bond_type_code,
				@issuer_type_code = issuer_type_code,
				@delivery_code = delivery_code
			from security
			where security_id = @security_id;
			if @major_asset_code <> 4
			begin
				execute @ret_val = get_next_valid_business_day 
										 @valid_business_date = @trade_date output,
										 @country_code = @exchange_country_code,
										 @exchange_code = @exchange_code,
										 @major_asset_code = @major_asset_code,
										 @minor_asset_code = @minor_asset_code,
										 @bond_type_code = @bond_type_code,
										 @issuer_type_code = @issuer_type_code,
										 @delivery_code = @delivery_code,
										 @offset = 0,
										 @check_exchange_closing_time = 1
										 ;	
				execute @ret_val = get_settlement_days  @calendar_days = @offset output, @country_code = @exchange_country_code, @security_id = @security_id, @trade_date = @trade_date;
				select @settlement_date = dateadd(dd, @offset, @trade_date);
				execute @ret_val = valid_settle_day 
	 											@valid_settle_day = @valid_settle_day output,
	 											@country_code = @exchange_country_code,
	 											@dated = @settlement_date,
	 											@exchange_code = @exchange_code,
	 											@major_asset_code = @major_asset_code,
	 											@minor_asset_code = @minor_asset_code,
	 											@bond_type_code = @bond_type_code,
	 											@issuer_type_code = @issuer_type_code,
	 											@delivery_code = @delivery_code
	 											;
				if @valid_settle_day = 0
				begin
					while @valid_settle_day = 0
					begin
						select @settlement_date = dateadd(dd, 1, @settlement_date);
						execute @ret_val = valid_settle_day 
	 											@valid_settle_day = @valid_settle_day output,
	 											@country_code = @exchange_country_code,
	 											@dated = @settlement_date,
	 											@exchange_code = @exchange_code,
	 											@major_asset_code = @major_asset_code,
	 											@minor_asset_code = @minor_asset_code,
	 											@bond_type_code = @bond_type_code,
	 											@issuer_type_code = @issuer_type_code,
	 											@delivery_code = @delivery_code
	 											;
					end; 
				end;
				if @valid_settle_day = 1
				begin
					update #ordered_driver_ccy
					set effective_date = @settlement_date
					where security_id = @security_id 
						and	exchange_country_code = @exchange_country_code;
				end;
			end; 
			delete from #ordered_settle_date_driver
			where security_id = @security_id 
				and exchange_country_code = @exchange_country_code;
		end;  
    end; 
	if @ordered_equity_flag = 1 
		or @ordered_fund_flag = 1
		or @ordered_equity_ipo_flag = 1 
		or @ordered_eqty_sec_off_flag = 1
		or @ordered_future_flag = 1
		or @ordered_option_flag = 1 
		or @ordered_index_flag = 1 
		or @ordered_unclassified_flag = 1
	begin
		insert into #driver_gcmr
		(
			account_id,
			currency_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price,
			pricing_factor,
			principal_factor,
			accrued_income,
			mkt_val_display_curr,
			share_indicator,
			contract_size
		)
		select 
			#ordered_driver_ccy.account_id,
			#ordered_driver_ccy.currency_code,
			#ordered_driver_ccy.quantity,
			#ordered_driver_ccy.effective_date,
			#ordered_driver_ccy.currency_exchange_rate,
			#ordered_driver_ccy.multiplier_sign,
			#ordered_driver_ccy.price,
			#ordered_driver_ccy.pricing_factor,
			#ordered_driver_ccy.principal_factor,
			#ordered_driver_ccy.accrued_income,
			case
				when #ordered_driver_ccy.share_indicator = 0
					then #ordered_driver_ccy.multiplier_sign 
					* (#ordered_driver_ccy.quantity 
					* @display_exchange_rate) 
				end,
			#ordered_driver_ccy.share_indicator,
			#ordered_driver_ccy.contract_size
		from 
			#ordered_driver_ccy
		where 
			#ordered_driver_ccy.effective_date >= @from_date and
			#ordered_driver_ccy.effective_date <= @end_date and
			#ordered_driver_ccy.quantity <> 0.0
		option (keepfixed plan);
	end; 
	if @proposed_equity_flag = 1
	begin
	   	insert into #proposed_driver_gcmr
	   	(
	   		account_id,
	   		security_id,
	   		exchange_country_code,
	   		currency_code,
	   		quantity,
	   		currency_exchange_rate,
	   		multiplier_sign,
	   		price,
	   		pricing_factor,
	   		principal_factor,
	   		accrued_income,
			effective_date,
			share_indicator
	   	)
		select 
			proposed_orders.account_id,
			security.security_id,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then proposed_orders.quantity
				else proposed_orders.market_value
				end,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			proposed_orders.accrued_income,
			proposed_orders.settlement_date,
			side.share_indicator
		from 
			proposed_orders,
			#account,
			security,
			price,
			exchange,
			currency,
			side
		where 
			proposed_orders.account_id = #account.account_id and
			proposed_orders.security_id = security.security_id and
			security.security_id = price.security_id and
			security.principal_currency_id = currency.security_id and 
			security.exchange_code = exchange.exchange_code and
			proposed_orders.ticket_type_code = 1 and
			proposed_orders.side_code = side.side_code and
			security.deleted = 0
		option (keepfixed plan);
	end; 
	if @proposed_equity_ipo_flag = 1
	begin
		insert into #proposed_driver_gcmr
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			currency_exchange_rate,
			multiplier_sign,
			price,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date,
			share_indicator
		)
		select 
			proposed_orders.account_id,
			security.security_id,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then proposed_orders.quantity
				else proposed_orders.market_value
				end,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			proposed_orders.accrued_income,
			proposed_orders.settlement_date,
			side.share_indicator
		from 
			proposed_orders,
			#account,
			security,
			price,
			exchange,
			currency,
			side
		where 
			proposed_orders.account_id = #account.account_id and
			proposed_orders.security_id = security.security_id and
			security.security_id = price.security_id and
			security.principal_currency_id = currency.security_id and 
			security.exchange_code = exchange.exchange_code and
			proposed_orders.ticket_type_code = 2 and
			proposed_orders.side_code = side.side_code and
			security.deleted = 0
		option (keepfixed plan);
	end; 
	if @proposed_eqty_sec_off_flag = 1
	begin
		insert into #proposed_driver_gcmr
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			currency_exchange_rate,
			multiplier_sign,
			price,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date,
			share_indicator
		)
		select 
			proposed_orders.account_id,
			security.security_id,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then proposed_orders.quantity
				else proposed_orders.market_value
				end,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			proposed_orders.accrued_income,
			proposed_orders.settlement_date,
			side.share_indicator
		from 
			proposed_orders,
			#account,
			security,
			price,
			exchange,
			currency,
			side
		where
			proposed_orders.account_id = #account.account_id and
			proposed_orders.security_id = security.security_id and
			security.security_id = price.security_id and
			security.principal_currency_id = currency.security_id and 
			security.exchange_code = exchange.exchange_code and
			proposed_orders.ticket_type_code = 3 and
			proposed_orders.side_code = side.side_code and
			security.deleted = 0
		option (keepfixed plan);
	end; 
	if @proposed_debt_flag = 1
	begin	
		insert into #driver_gcmr
		(
			account_id,
			currency_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price,
			pricing_factor,
			principal_factor,
			accrued_income,
			mkt_val_display_curr,
			share_indicator
		)
		select 
			proposed_orders.account_id,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then proposed_orders.quantity
				else proposed_orders.market_value
				end,
			proposed_orders.settlement_date,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			proposed_orders.accrued_income,
			case
				when side.share_indicator = 0
					then side.market_value_sign 
					* (proposed_orders.market_value 
					* @display_exchange_rate) 
				end,
			side.share_indicator
		from 
			proposed_orders,
			#account,
			security,
			price,
			currency,
			side
		where 
			proposed_orders.account_id = #account.account_id and
			proposed_orders.security_id = security.security_id and
			security.security_id = price.security_id and
			security.principal_currency_id = currency.security_id and
			proposed_orders.side_code = side.side_code and
			proposed_orders.ticket_type_code in (5, 13) and
			proposed_orders.settlement_date >= @from_date and
			proposed_orders.settlement_date <= @end_date and
			security.deleted = 0
		option (keepfixed plan);
	end;
	if @proposed_fund_flag = 1
	begin
		insert into #proposed_driver_gcmr
		(
			account_id,
			security_id,
			order_id,
			exchange_country_code,
			currency_code,
			quantity,
			currency_exchange_rate,
			multiplier_sign,
			price,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date,
			share_indicator
		)
		select 
			proposed_orders.account_id,
			security.security_id,
			proposed_orders.order_id,
			coalesce(exchange.country_code, security.country_code ),
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then proposed_orders.quantity
				else proposed_orders.market_value
				end,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			proposed_orders.accrued_income,
			proposed_orders.settlement_date,
			side.share_indicator
		from proposed_orders
		join #account 
			on proposed_orders.account_id = #account.account_id
		join security 
			on proposed_orders.security_id = security.security_id
		join price 
			on security.security_id = price.security_id
		left outer join exchange 
			on security.exchange_code = exchange.exchange_code
		join currency 
			on security.principal_currency_id = currency.security_id
		join side 
			on proposed_orders.side_code = side.side_code
		where
			proposed_orders.ticket_type_code = 6 and
			security.deleted = 0
			option (keepfixed plan);
		insert into #proposed_trade_date_driver 
		(
			order_id,
			security_id,
			exchange_country_code
		)select distinct
			#proposed_driver_gcmr.order_id,
			#proposed_driver_gcmr.security_id,
			#proposed_driver_gcmr.exchange_country_code
		from #proposed_driver_gcmr
		join proposed_orders
			on proposed_orders.order_id = #proposed_driver_gcmr.order_id
		where proposed_orders.ticket_type_code = 6 
			and #proposed_driver_gcmr.effective_date is null
		option (keepfixed plan);
		while exists(
			select 1 
			from #proposed_trade_date_driver
		) begin
			select @order_id = min(order_id) 
			from #proposed_trade_date_driver;
			select 
				@security_id = security_id,
				@exchange_country_code = exchange_country_code 
			from #proposed_trade_date_driver
			where order_id = @order_id;
			select @exchange_code = exchange_code,
				@major_asset_code = major_asset_code,
				@minor_asset_code = minor_asset_code,
				@bond_type_code = bond_type_code,
				@issuer_type_code = issuer_type_code,
				@delivery_code = delivery_code
			from security
			where security_id = @security_id;	
			select @trade_date = @current_date;
			select @trade_date_offset = trade_date_offset 
			from proposed_orders
			where order_id = @order_id;	
			execute @ret_val = get_next_valid_business_day 
											@valid_business_date = @trade_date output,
											@country_code = @exchange_country_code,
											@exchange_code = @exchange_code,
											@major_asset_code = @major_asset_code,
											@minor_asset_code = @minor_asset_code,
											@bond_type_code = @bond_type_code,
											@issuer_type_code = @issuer_type_code,
											@delivery_code = @delivery_code,
											@offset = @trade_date_offset,
											@check_exchange_closing_time = 1
											;			
			execute @ret_val = get_settlement_days  @calendar_days = @offset output, @country_code = @exchange_country_code, @security_id = @security_id, @trade_date = @trade_date;
			select @settlement_date = dateadd(dd, @offset, @trade_date);
			execute @ret_val = valid_settle_day 
										@valid_settle_day = @valid_settle_day output,
										@country_code = @exchange_country_code,
										@dated = @settlement_date,
										@exchange_code = @exchange_code,
										@major_asset_code = @major_asset_code,
										@minor_asset_code = @minor_asset_code,
										@bond_type_code = @bond_type_code,
										@issuer_type_code = @issuer_type_code,
										@delivery_code = @delivery_code
										;
			if @valid_settle_day = 0
			begin
				while @valid_settle_day = 0
				begin
					select @settlement_date = dateadd(dd, 1, @settlement_date);
					execute @ret_val = valid_settle_day 
										@valid_settle_day = @valid_settle_day output,
										@country_code = @exchange_country_code,
										@dated = @settlement_date,
										@exchange_code = @exchange_code,
										@major_asset_code = @major_asset_code,
										@minor_asset_code = @minor_asset_code,
										@bond_type_code = @bond_type_code,
										@issuer_type_code = @issuer_type_code,
											@delivery_code = @delivery_code
										;
				end; 
		end; 
		if @valid_settle_day = 1
		begin
			update #proposed_driver_gcmr
			set effective_date = @settlement_date
			where order_id = @order_id
			option (keepfixed plan);
		end; 
		delete from #proposed_trade_date_driver
		where order_id = @order_id
		option (keepfixed plan);
		end; 
	end;
	if @proposed_future_flag = 1
	begin		
		insert into #proposed_driver_gcmr
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			currency_exchange_rate,
			multiplier_sign,
			price,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date,
			share_indicator,
			contract_size
		)
		select 
			proposed_orders.account_id,
			security.security_id,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.buy_indicator = 1
					then 0
				when side.share_indicator = 1
					then proposed_orders.quantity
				else proposed_orders.market_value
				end,
			currency.exchange_rate,
			side.market_value_sign,
			case
				when positions.last_mark is not null
					then price.latest-positions.last_mark
				when positions.unit_cost is not null
					then price.latest-positions.unit_cost
				else price.latest
				end,
			security.pricing_factor,
			security.principal_factor,
			proposed_orders.accrued_income,
			proposed_orders.settlement_date,
			side.share_indicator,
			security.contract_size	
		from 
			proposed_orders
			join #account
				on proposed_orders.account_id = #account.account_id
			join security
				on proposed_orders.security_id = security.security_id
			join price
				on security.security_id = price.security_id
			join exchange
				on security.exchange_code = exchange.exchange_code
			join currency
				on currency.security_id = security.principal_currency_id
			join side
				on side.side_code = proposed_orders.side_code
			left outer join positions
				on positions.account_id = #account.account_id and
				   positions.security_id = security.security_id and
				   positions.position_type_code = proposed_orders.position_type_code
		where 
			 proposed_orders.ticket_type_code = 7 and
			 security.deleted = 0
		option (keepfixed plan);
	end; 
	if @proposed_forward_flag = 1
	begin
		insert into #driver_gcmr
		(
			account_id,
			currency_code,
			security_id,
			ticket_type_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price
		)
		select 
			proposed_orders.account_id,
			security.principal_currency_id,
			proposed_orders.security_id,
			proposed_orders.ticket_type_code,
			proposed_orders.quantity,
			proposed_orders.settlement_date,
			currency.exchange_rate,
			side.security_sign,
			1
		from 
			proposed_orders,
			#account,
			security,
			currency,
			side
		where 
			proposed_orders.account_id = #account.account_id and
			proposed_orders.security_id = security.security_id and
			security.principal_currency_id = currency.security_id and
			proposed_orders.side_code = side.side_code and
			proposed_orders.ticket_type_code = 8 and
			proposed_orders.settlement_date >= @from_date and
			proposed_orders.settlement_date <= @end_date and
			security.deleted = 0
		option (keepfixed plan);
		insert into #driver_gcmr
		(
			account_id,
			currency_code,
			security_id,
			ticket_type_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price
		)
		select 
			proposed_orders.account_id,
			security.settlement_currency_id,
			proposed_orders.security_id,
			proposed_orders.ticket_type_code,
			proposed_orders.quantity,
			proposed_orders.settlement_date,
			currency.exchange_rate,
			side.market_value_sign,
			null
		from 
			proposed_orders,
			#account,
			security,
			currency,
			side
		where 
			proposed_orders.account_id = #account.account_id and
			proposed_orders.security_id = security.security_id and
			security.settlement_currency_id = currency.security_id and
			proposed_orders.side_code = side.side_code and
			proposed_orders.ticket_type_code = 8 and
			proposed_orders.settlement_date >= @from_date and
			proposed_orders.settlement_date <= @end_date and
			security.deleted = 0
		option (keepfixed plan);
	end; 
	if @proposed_option_flag = 1
	begin
		insert into #proposed_driver_gcmr
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			currency_exchange_rate,
			multiplier_sign,
			price,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date
		)
		select 
			proposed_orders.account_id,
			security.security_id,
			exchange.country_code,
			security.principal_currency_id,
			proposed_orders.quantity,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			proposed_orders.accrued_income,
			proposed_orders.settlement_date
		from 
			proposed_orders,
			#account,
			security,
			price,
			exchange,
			currency,
			side
		where 
			proposed_orders.account_id = #account.account_id and
			proposed_orders.security_id = security.security_id and
			security.security_id = price.security_id and
			security.principal_currency_id = currency.security_id and 
			security.exchange_code = exchange.exchange_code and
			proposed_orders.ticket_type_code = 9 and
			proposed_orders.side_code = side.side_code and
			security.deleted = 0
		option (keepfixed plan);
	end; 
	if @proposed_index_flag = 1
	begin
		insert into #proposed_driver_gcmr
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			currency_exchange_rate,
			multiplier_sign,
			price,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date,
			share_indicator
		)
		select 
			proposed_orders.account_id,
			security.security_id,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then proposed_orders.quantity
				else proposed_orders.market_value
				end,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			proposed_orders.accrued_income,
			proposed_orders.settlement_date,
			side.share_indicator
		from 
			proposed_orders,
			#account,
			security,
			price,
			exchange,
			currency,
			side
		where 
			proposed_orders.account_id = #account.account_id and
			proposed_orders.security_id = security.security_id and
			security.security_id = price.security_id and
			security.principal_currency_id = currency.security_id and 
			security.exchange_code = exchange.exchange_code and
			proposed_orders.ticket_type_code = 10 and
			proposed_orders.side_code = side.side_code and
			security.deleted = 0
		option (keepfixed plan);
	end; 
	if @proposed_unclassified_flag = 1
	begin		
		insert into #proposed_driver_gcmr
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			currency_exchange_rate,
			multiplier_sign,
			price,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date,
			share_indicator,
			contract_size
		)
		select 
			proposed_orders.account_id,
			security.security_id,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then proposed_orders.quantity
				else proposed_orders.market_value
				end,
			currency.exchange_rate,
			side.market_value_sign,
			price.latest,
			security.pricing_factor,
			security.principal_factor,
			proposed_orders.accrued_income,
			proposed_orders.settlement_date,
			side.share_indicator,
			security.contract_size
		from 
			proposed_orders,
			#account,
			security,
			price,
			exchange,
			currency,
			side
		where 
			proposed_orders.account_id = #account.account_id and
			proposed_orders.security_id = security.security_id and
			security.security_id = price.security_id and
			security.principal_currency_id = currency.security_id and 
			security.exchange_code = exchange.exchange_code and
			proposed_orders.ticket_type_code = 11 and
			proposed_orders.side_code = side.side_code and
			security.deleted = 0
		option (keepfixed plan);
	end; 
	if @proposed_spot_flag = 1
	begin
		insert into #driver_gcmr
		(
			account_id,
			currency_code,
			security_id,
			ticket_type_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price
		)
		select 
			proposed_orders.account_id,
			security.principal_currency_id,
			proposed_orders.security_id,
			proposed_orders.ticket_type_code,
			proposed_orders.quantity,
			proposed_orders.settlement_date,
			currency.exchange_rate,
			side.security_sign,
			1
		from 
			proposed_orders,
			#account,
			security,
			price,
			currency,
			side
		where 
			proposed_orders.account_id = #account.account_id and
			proposed_orders.security_id = security.security_id and
			security.security_id = price.security_id and
			security.principal_currency_id = currency.security_id and
			proposed_orders.side_code = side.side_code and
			proposed_orders.ticket_type_code = 12 and
			proposed_orders.settlement_date >= @from_date and
			proposed_orders.settlement_date <= @end_date and
			security.deleted = 0
		option (keepfixed plan);
		insert into #driver_gcmr
		(
			account_id,
			currency_code,
			security_id,
			ticket_type_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price
		)
		select 
			proposed_orders.account_id,
			security.settlement_currency_id,
			proposed_orders.security_id,
			proposed_orders.ticket_type_code,
			proposed_orders.quantity,
			proposed_orders.settlement_date,
			currency.exchange_rate,
			side.market_value_sign, 
			price.latest
		from 
			proposed_orders,
			#account,
			security,
			price,
			currency,
			side
		where 
			proposed_orders.account_id = #account.account_id and
			proposed_orders.security_id = security.security_id and
			security.security_id = price.security_id and
			security.settlement_currency_id = currency.security_id and
			proposed_orders.side_code = side.side_code and
			proposed_orders.ticket_type_code = 12 and
			proposed_orders.settlement_date >= @from_date and
			proposed_orders.settlement_date <= @end_date and
			security.deleted = 0
		option (keepfixed plan);
	end; 
	if @proposed_equity_flag = 1 
		or @proposed_equity_ipo_flag = 1 
		or @proposed_eqty_sec_off_flag = 1
		or @proposed_future_flag = 1
		or @proposed_option_flag = 1 
		or @proposed_index_flag = 1 
		or @proposed_unclassified_flag = 1
	begin
		insert into #proposed_trade_date_driver 
		(
			security_id,
			exchange_country_code
		)
		select distinct
			security_id,	
			exchange_country_code
		from
			#proposed_driver_gcmr
		 where effective_date is null
		option (keepfixed plan);
		select @trade_date = @current_date;
		while exists(
			select 1 
			from #proposed_trade_date_driver
		) begin
			select @security_id = min(security_id) 
			from #proposed_trade_date_driver;
			select @exchange_country_code = exchange_country_code 
			from #proposed_trade_date_driver
			where security_id = @security_id;
			select @exchange_code = exchange_code,
				@major_asset_code = major_asset_code,
				@minor_asset_code = minor_asset_code,
				@bond_type_code = bond_type_code,
				@issuer_type_code = issuer_type_code,
				@delivery_code = delivery_code
			from security
			where security_id = @security_id;	
			if 	@major_asset_code <> 4
			begin
				execute @ret_val = get_next_valid_business_day 
										 @valid_business_date = @trade_date output,
										 @country_code = @exchange_country_code,
										 @exchange_code = @exchange_code,
										 @major_asset_code = @major_asset_code,
										 @minor_asset_code = @minor_asset_code,
										 @bond_type_code = @bond_type_code,
										 @issuer_type_code = @issuer_type_code,
										 @delivery_code = @delivery_code,
										 @offset = 0,
										 @check_exchange_closing_time = 1
										 ;	
				execute @ret_val = get_settlement_days  @calendar_days = @offset output, @country_code = @exchange_country_code, @security_id = @security_id, @trade_date = @trade_date;
				select @settlement_date = dateadd(dd, @offset, @trade_date);
				execute @ret_val = valid_settle_day 
	 										@valid_settle_day = @valid_settle_day output,
	 										@country_code = @exchange_country_code,
	 										@dated = @settlement_date,
	 										@exchange_code = @exchange_code,
	 										@major_asset_code = @major_asset_code,
	 										@minor_asset_code = @minor_asset_code,
	 										@bond_type_code = @bond_type_code,
	 										@issuer_type_code = @issuer_type_code,
	 										@delivery_code = @delivery_code
	 										;
				if @valid_settle_day = 0
				begin
					while @valid_settle_day = 0
					begin
						select @settlement_date = dateadd(dd, 1, @settlement_date);
						execute @ret_val = valid_settle_day 
	 										@valid_settle_day = @valid_settle_day output,
	 										@country_code = @exchange_country_code,
	 										@dated = @settlement_date,
	 										@exchange_code = @exchange_code,
	 										@major_asset_code = @major_asset_code,
	 										@minor_asset_code = @minor_asset_code,
	 										@bond_type_code = @bond_type_code,
	 										@issuer_type_code = @issuer_type_code,
	 											@delivery_code = @delivery_code
	 										;
					end; 
				end; 
				if @valid_settle_day = 1
				begin
					update #proposed_driver_gcmr
					set effective_date = @settlement_date
					where security_id = @security_id and
						exchange_country_code = @exchange_country_code
					option (keepfixed plan);
				end; 
			end; 
			delete from #proposed_trade_date_driver
			where security_id = @security_id 
				and exchange_country_code = @exchange_country_code
			option (keepfixed plan);
		end; 
    end; 
	if @proposed_equity_flag = 1
		or @proposed_fund_flag = 1  
		or @proposed_equity_ipo_flag = 1 
		or @proposed_eqty_sec_off_flag = 1
		or @proposed_future_flag = 1
		or @proposed_option_flag = 1 
		or @proposed_index_flag = 1 
		or @proposed_unclassified_flag = 1
	begin
		insert into #driver_gcmr
		(
			account_id,
			currency_code,
			quantity,
			effective_date,
			currency_exchange_rate,
			multiplier_sign,
			price,
			pricing_factor,
			principal_factor,
			accrued_income,
			mkt_val_display_curr,
			share_indicator,
			contract_size
		)
		select 
			#proposed_driver_gcmr.account_id,
			#proposed_driver_gcmr.currency_code,
			#proposed_driver_gcmr.quantity,
			#proposed_driver_gcmr.effective_date,
			#proposed_driver_gcmr.currency_exchange_rate,
			#proposed_driver_gcmr.multiplier_sign,
			#proposed_driver_gcmr.price,
			#proposed_driver_gcmr.pricing_factor,
			#proposed_driver_gcmr.principal_factor,
			#proposed_driver_gcmr.accrued_income,
			case
				when #proposed_driver_gcmr.share_indicator = 0
					then #proposed_driver_gcmr.multiplier_sign 
					* (#proposed_driver_gcmr.quantity 
					* @display_exchange_rate) 
				end,
			#proposed_driver_gcmr.share_indicator,
			#proposed_driver_gcmr.contract_size
		from 
			#proposed_driver_gcmr
		where 
			#proposed_driver_gcmr.effective_date >= @from_date and
			#proposed_driver_gcmr.effective_date <= @end_date
		option (keepfixed plan);
	end; 
	if exists(
		select 1 
		from #driver_gcmr 
		where ticket_type_code = 8 
	) begin
		insert into #forward_info 
		(
			security_id
		)
		select distinct security_id
		from #driver_gcmr
		where 
			#driver_gcmr.ticket_type_code = 8 and
			#driver_gcmr.security_id is not null;
		select @fx_current_date = getdate();
		select @system_currency_id = security_id 
		from currency 
		where currency.system_currency = 1;
		select @security_id = min(security_id) 
		from #forward_info;
		while @security_id is not null
		begin
			select @fx_trade_sec_id = security.principal_currency_id,
				@fx_settle_sec_id = security.settlement_currency_id,
				@settlement_date = security.maturity_date 
			from security
			where security.security_id = @security_id;
			select @fx_settle_spot_rate = null;
			execute @ret_val = interpolate_forward_rate 
	 	                    @forward_rate = @fx_settle_spot_rate output,
	 	                    @principal_currency_id = @system_currency_id,
	 	                    @counter_currency_id = @fx_settle_sec_id,
	 	                     @settlement_date = @fx_current_date
	 	                    ;
			select @fx_trade_to_settle_rate = null;
			execute @ret_val = interpolate_forward_rate 
	 	                    @forward_rate = @fx_trade_to_settle_rate output,
	 	                    @principal_currency_id = @fx_trade_sec_id,
	 	                    @counter_currency_id = @fx_settle_sec_id,
	 	                     @settlement_date = @settlement_date
	 	                    ; 
			update #forward_info
			set trade_to_settle_rate	= coalesce(@fx_trade_to_settle_rate, 1.0),
				settle_spot_rate		= coalesce(@fx_settle_spot_rate, 1.0)
			where security_id = @security_id;
			select @security_id = min(security_id) 
			from #forward_info 
			where trade_to_settle_rate is null 
				and settle_spot_rate is null;
		end;
update #driver_gcmr 
			set	mkt_val_display_curr	= (
					#driver_gcmr.multiplier_sign 
					*( #driver_gcmr.quantity 
					/ coalesce(#driver_gcmr.price, #forward_info.trade_to_settle_rate)
					* #forward_info.settle_spot_rate
					* @display_exchange_rate
					* coalesce(#driver_gcmr.pricing_factor, 1) 
					* coalesce(#driver_gcmr.principal_factor,1) 
					* coalesce (#driver_gcmr.contract_size, 1)
					+ coalesce(#driver_gcmr.accrued_income, 0)
					- coalesce(#driver_gcmr.commission, 0))
					),
				price = coalesce(#driver_gcmr.price, 1 / #forward_info.trade_to_settle_rate)
		from #driver_gcmr
		join security 
			on security.security_id = #driver_gcmr.security_id
		join #forward_info 
			on #forward_info.security_id = #driver_gcmr.security_id
		where #driver_gcmr.ticket_type_code = 8
			and security.settlement_currency_id = #driver_gcmr.currency_code;
update #driver_gcmr 
		set	mkt_val_display_curr	= (
				#driver_gcmr.multiplier_sign 
				*( #driver_gcmr.quantity 
				/ #forward_info.trade_to_settle_rate 
				* #forward_info.settle_spot_rate
				* @display_exchange_rate
				* coalesce(#driver_gcmr.pricing_factor, 1) 
				* coalesce(#driver_gcmr.principal_factor,1) 
				* coalesce (#driver_gcmr.contract_size, 1)
				+ coalesce(#driver_gcmr.accrued_income, 0)
				- coalesce(#driver_gcmr.commission, 0))
				)
		from #driver_gcmr
		join security 
			on security.security_id = #driver_gcmr.security_id
		join #forward_info 
			on #forward_info.security_id = #driver_gcmr.security_id
		where #driver_gcmr.ticket_type_code = 8
			and security.principal_currency_id = #driver_gcmr.currency_code;
	end;
	update #driver_gcmr 
	set	mkt_val_display_curr = 
			#driver_gcmr.multiplier_sign 
			* (#driver_gcmr.quantity 
			* (@display_exchange_rate / #driver_gcmr.currency_exchange_rate) 
			* #driver_gcmr.price 
			* coalesce(#driver_gcmr.pricing_factor, 1) 
			* coalesce(#driver_gcmr.principal_factor,1) 
			* coalesce (#driver_gcmr.contract_size, 1)
			+ coalesce(#driver_gcmr.accrued_income, 0)
			- coalesce(#driver_gcmr.commission, 0))
	where mkt_val_display_curr is null;
	insert into #final_driver_gcmr 
	(
		account_id,
		currency_code,
		quantity,
		effective_date,
		mkt_val_display_currency,
		currency_exchange_rate,
		price,
		multiplier_sign
	)
	select 
		#driver_gcmr.account_id,
		#driver_gcmr.currency_code,
		case
			when #driver_gcmr.share_indicator = 0
				then #driver_gcmr.multiplier_sign 
				* sum(#driver_gcmr.quantity 
				*  #driver_gcmr.currency_exchange_rate)
			else #driver_gcmr.multiplier_sign 
				* sum(#driver_gcmr.quantity 
				* #driver_gcmr.price 
				* coalesce(#driver_gcmr.pricing_factor, 1) 
				* coalesce(#driver_gcmr.principal_factor,1) 
				* coalesce (#driver_gcmr.contract_size, 1)
				+ coalesce(#driver_gcmr.accrued_income, 0)
				- coalesce(#driver_gcmr.commission, 0))
			end 
			as quantity,
		#driver_gcmr.effective_date,
		sum(#driver_gcmr.mkt_val_display_curr),
		#driver_gcmr.currency_exchange_rate,
		#driver_gcmr.price,
		#driver_gcmr.multiplier_sign
	from 
		account,
		#driver_gcmr,
		currency
	where 
		#driver_gcmr.account_id = account.account_id and
		#driver_gcmr.currency_code = currency.security_id and
		#driver_gcmr.quantity <> 0
	group by 
		#driver_gcmr.account_id,
		#driver_gcmr.currency_code, 
		#driver_gcmr.effective_date,
		#driver_gcmr.currency_exchange_rate,
		#driver_gcmr.price,
		#driver_gcmr.multiplier_sign,
		#driver_gcmr.share_indicator
	option (keepfixed plan);

	/*

se_get_currency_mvmt_report_sum '2018/5/1 00:00:00.000 ', '2018/5/8 00:00:00.000 ', 218, null, 
1.00000000, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 189.00000000

get_currency_mvmt_report '2018/5/1 00:00:00.000 ', '2018/5/8 00:00:00.000 ', 199, null, 1.00000000, 1, 
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 189.00000000


*/



insert  into #almost_final_driver_gcmr
select
	    Sum (#final_driver_gcmr.mkt_val_display_currency)		as closing_balance_disp_ccy_summed,
		#final_driver_gcmr.account_id,
		#final_driver_gcmr.currency_code				as currency_id
	from 
		#final_driver_gcmr,
		account,
		currency
	where 
	#final_driver_gcmr.account_id = account.account_id and
	#final_driver_gcmr.currency_code = currency.security_id and
	#final_driver_gcmr.quantity <> 0.0
	group by #final_driver_gcmr.account_id,
	#final_driver_gcmr.currency_code

	--select * from #proposed_driver_gcmr
	--select * from #proposed_trade_date_driver 
	

	select 
	    CONVERT(DATETIME,CONVERT(VARCHAR(12),GETDATE(),112)) as 'current_date',
	    Sum (#final_driver_gcmr.mkt_val_display_currency)		as closing_balance_disp_ccy,
	    sum(#final_driver_gcmr.quantity)                        as Quantity,
		#almost_final_driver_gcmr.sumMV,
		account.short_name								        as account_short_name,
		currency.mnemonic								        as currency_mnemonic,
		#final_driver_gcmr.effective_date,
		#final_driver_gcmr.account_id,
		#final_driver_gcmr.currency_code				as currency_id,
		--@display_exchange_rate							as display_exchange_rate,
		currency.mnemonic								as trade_currency_mnemonic,
		--@display_mnemonic								as display_currency_mnemonic,
		currency.exchange_rate							as trade_currency_exchg_rate,
		''                                            as Header
	from 
		#final_driver_gcmr,
		account,
		currency,
		#almost_final_driver_gcmr
	
	where 
	#final_driver_gcmr.account_id = account.account_id and
	#final_driver_gcmr.currency_code = currency.security_id and
	#final_driver_gcmr.quantity <> 0.0
	and #almost_final_driver_gcmr.account_id = #final_driver_gcmr.account_id
	and #almost_final_driver_gcmr.currency_code = currency.security_id 
	
	group by account.short_name,
	#final_driver_gcmr.effective_date,
	#final_driver_gcmr.currency_code,
	currency.mnemonic,
	#final_driver_gcmr.account_id,
	#almost_final_driver_gcmr.sumMV,
	currency.exchange_rate

	order by
	account.short_name,
	currency.mnemonic;
	
end

go
if @@error = 0 print 'PROCEDURE: se_get_currency_mvmt_report_sum created'
else print 'PROCEDURE: se_get_currency_mvmt_report_sum error on creation'
go