if exists (select * from sysobjects where name = 'se_get_currency_mvmt_detail')
begin
	drop procedure se_get_currency_mvmt_detail
	print 'PROCEDURE: se_get_currency_mvmt_detail dropped'
end
go

/*

se_get_currency_mvmt_detail '2018/5/10 08:59:38.902 ', '2018/5/17 08:59:38.902', 199.00000000,1,189

*/

create procedure [dbo].[se_get_currency_mvmt_detail]
(
	@from_date					datetime, 
	@end_date					datetime, 
	@account_id					numeric(10), 
	@currency_code				numeric(10), 
	@current_user numeric(10)
) 
as

	declare @proposed_equity_flag		tinyint = 0,
	@display_currency_id		numeric(10) = null,
	@proposed_equity_ipo_flag	tinyint = 0,
	@proposed_eqty_sec_off_flag	tinyint = 0,
	@proposed_debt_flag			tinyint = 0,
	@proposed_fund_flag			tinyint = 0,
	@proposed_future_flag		tinyint = 0,
	@proposed_forward_flag		tinyint = 0,
	@proposed_option_flag		tinyint = 0,
	@proposed_index_flag		tinyint = 0,
	@proposed_unclassified_flag	tinyint = 0,
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
	declare @unconfirmed_settle_mvmt	tinyint;
	declare @confirmed_settle_mvmt		tinyint;
	declare @unconfirmed_spot_mvmt		tinyint;
	declare @confirmed_spot_mvmt		tinyint;
	declare @cash_position_mvmt			tinyint;
	declare @display_exchange_rate		float;
	declare @exchange_country_code		numeric(10);
	declare @exchange_code				numeric(10);
	declare @major_asset_code			smallint;
	declare @minor_asset_code			smallint;
	declare @bond_type_code				smallint;
	declare @issuer_type_code			tinyint;
	declare @delivery_code				smallint;
	declare @valid_settle_day			tinyint;
	declare @settlement_date			datetime;
	declare @current_date				nvarchar(11);
	declare @maximum_date_range			int;
	declare @security_id				numeric(10);
	declare @offset						int;
	declare @trade_date					datetime;
	declare @valid_trade_day			tinyint;
	declare @ordered					nvarchar(8);
	declare @ordered_cash				nvarchar(16);
	declare @proposed					nvarchar(8);
	declare @proposed_cash				nvarchar(16);
	declare @unconfirmed_cash_mvmt		tinyint;
	declare @confirmed_cash				nvarchar(16);
	declare @server_utc_offset			int;
	declare @est_utc_offset				int;
	declare @current_date_time			nvarchar(20);
	declare @canceled					nvarchar(8);
	declare @modified					nvarchar(8);
	declare @confirmed_spot_cash_mvmt	tinyint;
	declare @allocations_sum			int;
	declare @ret_val int;
	declare @display_currency_local		numeric(10);
begin
                        set nocount on;
                        declare @ec__errno int;
                        declare @sp_initial_trancount int;
                        declare @sp_trancount int;
	create table #driver_gcmd  	(  		account_id				numeric(10) null,  		currency_code			numeric(10) null,  		security_id				numeric(10) null,  		quantity				float null,  		effective_date			datetime null,  		ccy_mvmt_type_code		smallint null,  		multiplier_sign			smallint null,  		side_code				tinyint null,  		price					float null,  		order_type				nvarchar(16) null,  		ticket_type_code		tinyint null,  		position_type_code		tinyint null,  		order_id				numeric(10) null,  		override_check			tinyint null,  		trade_status			nvarchar(8) null,  		pricing_factor			float null,  		principal_factor		float null,  		cm_user_field_1			nvarchar(40) null,  		cm_user_field_2			nvarchar(40) null,  		cm_user_field_3			nvarchar(40) null,  		cm_user_field_4			nvarchar(40) null,  		cm_user_field_5			float null,  		cm_user_field_6			float null,  		cm_user_field_7			float null,  		cm_user_field_8			float null,  		accrued_income			float null,  		share_indicator			bit null,  		contract_size			float null,  		commission				float null  	);
	create table #opening_alloc_totals  	(  		security_id						numeric(10) null,  		account_id						numeric(10) null,  		position_type_code				tinyint null,  		total_opening_alloc_cost		float null,  		total_opening_alloc_quantity	float null  	);
	create table #user_ccy_mvmt_type  	(  		ccy_mvmt_type_code smallint null  	);
	create table #final_driver_gcmd  	(  		account_id			numeric(10) null,  		currency_code		numeric(10) null,  		security_id			numeric(10) null,  		quantity			float null,  		effective_date		datetime null,  		ccy_mvmt_type_code	smallint null,  		multiplier_sign		smallint null,  		side_code			tinyint null,  		price				float null,  		order_type			nvarchar(16) null,  		ticket_type_code	tinyint null,  		position_type_code	tinyint null,  		order_id			numeric(10) null,  		override_check		tinyint null,  		trade_status		nvarchar(8) null,  		cm_user_field_1		nvarchar(40) null,  		cm_user_field_2		nvarchar(40) null,  		cm_user_field_3		nvarchar(40) null,  		cm_user_field_4		nvarchar(40) null,  		cm_user_field_5		float null,  		cm_user_field_6		float null,  		cm_user_field_7		float null,  		cm_user_field_8		float null  	);
	create table #proposed_driver_gcmd  	(  		account_id				numeric(10) null,  		security_id				numeric(10) null,  		exchange_country_code	numeric(10) null,  		currency_code			numeric(10) null,  		quantity				float null,  		effective_date			datetime null,  		multiplier_sign			smallint null,  		side_code				tinyint null,  		price					float null,  		ticket_type_code		tinyint null,  		position_type_code		tinyint null,  		order_id				numeric(10) null,  		override_check			tinyint null,  		pricing_factor			float null,  		principal_factor		float null,  		accrued_income			float null, 		share_indicator			bit null,  		contract_size			float null  	) ;  
	create table #ordered_driver  	(  		account_id				numeric(10) null,  		security_id				numeric(10) null,  		exchange_country_code	numeric(10) null,  		currency_code			numeric(10) null,  		quantity				float null,  		effective_date			datetime null,  		multiplier_sign			smallint null,  		side_code				tinyint null,  		price					float null,  		ticket_type_code		tinyint null,  		pricing_factor			float null,  		principal_factor		float null,  		accrued_income			float null,  		share_indicator			bit null,  		contract_size			float null  		);
	create table #ordered_settle_date_driver  	(  		order_id  numeric(10) null,  		security_id numeric(10) null,  		exchange_country_code numeric(10) null  	);
	create table #proposed_trade_date_driver   	(  		order_id numeric(10),  		security_id numeric(10),  		exchange_country_code int null  	);
	create table #alloc_qty_gcmd  	(  		account_id				numeric(10) null,  		allocations_qty			float null,  		ticket_type_code		tinyint null,  		security_id				numeric(10) null,  		principal_currency_id	numeric(10) null,  		side_code				tinyint null,  		settlement_date			datetime null,  		allocated_accrued		float null  	);
	select @current_date = convert(datetime, convert(nvarchar(10), getdate(), 112), 112);	
	select @unconfirmed_settle_mvmt = 0;
	select @confirmed_settle_mvmt = 1;
	select @unconfirmed_spot_mvmt = 2;
	select @confirmed_spot_mvmt = 3;
	select @cash_position_mvmt = 15;
	select @ordered = 'Order';
	select @proposed = 'Proposed';
	select @proposed_cash = 'Proposed Cash';
	select @ordered_cash = 'Ordered Cash';
	select @unconfirmed_cash_mvmt = 17;
	select @confirmed_cash = 'Confirmed Cash';
	select @confirmed_spot_cash_mvmt = 18;
	select @est_utc_offset = -5;
	select @canceled = 'CANCELED';
	select @modified = 'MODIFIED';
	if @display_currency_id is null
	begin
		select 
			@display_currency_local = security_id 
		from currency 
		where currency.system_currency = 1.0
		;
	end else begin
		select @display_currency_local = @display_currency_id;
	end;
	select 
		@display_exchange_rate = exchange_rate 
	from currency 
	where security_id = @display_currency_local;
	insert into #user_ccy_mvmt_type
	(
		ccy_mvmt_type_code
	)
	select 
		ccy_mvmt_type_code
	from user_currency_movement_type
	where user_id = @current_user
	option (keepfixed plan);
	insert into #driver_gcmd
	(
		account_id,
		currency_code,
		security_id,
		quantity,
		effective_date,
		ccy_mvmt_type_code,
		multiplier_sign,
		price,
		cm_user_field_1,
		cm_user_field_2,
		cm_user_field_3,
		cm_user_field_4,
		cm_user_field_5,
		cm_user_field_6,
		cm_user_field_7,
		cm_user_field_8
	)
	select 
		currency_movement.account_id,
		currency_movement.currency_code,
		currency_movement.security_id,
		currency_movement.quantity,
		currency_movement.effective_date,
		currency_movement.ccy_mvmt_type_code,
		1,
		1,
		currency_movement.user_field_1,
		currency_movement.user_field_2,
		currency_movement.user_field_3,
		currency_movement.user_field_4,
		currency_movement.user_field_5,
		currency_movement.user_field_6,
		currency_movement.user_field_7,
		currency_movement.user_field_8
	from 
		currency_movement,
		#user_ccy_mvmt_type
	where 
		currency_movement.account_id = @account_id and
		currency_movement.currency_code = @currency_code and
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
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			ccy_mvmt_type_code,
			multiplier_sign,
			price
		)
		select 
			positions.account_id,
			security.principal_currency_id,
			positions.security_id,
			positions.quantity,
			@current_date,
			@cash_position_mvmt,
			position_type.security_sign,
			1
		from 
			positions,
			security,
			position_type,
			currency
		where 
			positions.account_id = @account_id and
			positions.security_id = security.security_id and
			security.major_asset_code = 0 and
			security.principal_currency_id = @currency_code and
			security.security_id = currency.security_id and
			positions.position_type_code = position_type.position_type_code and
			@current_date >= @from_date and
			@current_date <= @end_date and
			security.deleted = 0
		option (keepfixed plan);
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			ccy_mvmt_type_code,
			multiplier_sign,
			price
		)
		select 
			positions.account_id,
			security.principal_currency_id,
			positions.security_id,
			positions.quantity,
			@current_date,
			@cash_position_mvmt,
			position_type.security_sign,
			1
		from 
			positions,
			security,
			position_type,
			currency
		where 
			positions.account_id = @account_id and
			positions.security_id = security.security_id and
			security.major_asset_code = 0 and
			security.principal_currency_id = @currency_code and
			security.principal_currency_id = currency.security_id and
			security.minor_asset_code in (1, 2 ) and
			positions.position_type_code = position_type.position_type_code and
			@current_date >= @from_date and
			@current_date <= @end_date and
			security.deleted = 0
		option (keepfixed plan);
	end; 
	if exists(
		select 1 
		from #user_ccy_mvmt_type 
		where ccy_mvmt_type_code = @unconfirmed_settle_mvmt
	) begin
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			ccy_mvmt_type_code,
			multiplier_sign,
			side_code,
			price
		)
		select 
			allocations.account_id,
			allocations.settlement_currency_id,
			allocations.security_id,
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
			@unconfirmed_settle_mvmt,
			side.market_value_sign,
			allocations.side_code,
			1
		from 
			allocations
			join ticket 
				on allocations.ticket_id = ticket.ticket_id
			join side 
				on allocations.side_code = side.side_code			
			join security
				on allocations.security_id = security.security_id
			join currency
				on ticket.settlement_currency_id = currency.security_id
			left outer join cross_currency
				on security.principal_currency_id = cross_currency.principal_currency_id 
				and ticket.settlement_currency_id = cross_currency.counter_currency_id
			left outer join cross_currency cross_currency_inverted
				on security.principal_currency_id = cross_currency_inverted.counter_currency_id
				and ticket.settlement_currency_id = cross_currency_inverted.principal_currency_id
		where 
			allocations.account_id = @account_id and
			allocations.settlement_currency_id = @currency_code and			
			ticket.settlement_date >= @from_date and
			ticket.settlement_date <= @end_date and
			ticket.ticket_type_code not in (12, 8, 7) and
			ticket.deleted = 0 and
			allocations.primary_confirmed = 0 and
			allocations.primary_pending = 0 and 
			allocations.deleted = 0 
		option (keepfixed plan);
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			ccy_mvmt_type_code,
			multiplier_sign,
			side_code,
			price,
			trade_status
		)
		select 
			allocations.account_id,
			allocations.settlement_currency_id,
			allocations.security_id,
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
			@unconfirmed_settle_mvmt,
			side.market_value_sign,
			allocations.side_code,
			1,
			@modified
		from
			allocations
			join ticket 
				on allocations.ticket_id = ticket.ticket_id
			join side 
				on allocations.side_code = side.side_code
			join security
				on allocations.security_id = security.security_id
			join currency
				on ticket.settlement_currency_id = currency.security_id
			left outer join cross_currency
				on security.principal_currency_id = cross_currency.principal_currency_id 
				and ticket.settlement_currency_id = cross_currency.counter_currency_id
			left outer join cross_currency cross_currency_inverted
				on security.principal_currency_id = cross_currency_inverted.counter_currency_id
				and ticket.settlement_currency_id = cross_currency_inverted.principal_currency_id
		where 
			allocations.account_id = @account_id and
			allocations.settlement_currency_id = @currency_code and
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
				 side
			where allocations.account_id = @account_id
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
			insert into #driver_gcmd
			(
				account_id,
				currency_code,
				security_id,
				ticket_type_code,
				quantity,
				effective_date,
				ccy_mvmt_type_code,
				multiplier_sign,
				side_code,
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
				@unconfirmed_settle_mvmt,
				side.market_value_sign,
				allocations.side_code,
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
				allocations
				join ticket
					on ticket.ticket_id = allocations.ticket_id
				join side
					on side.side_code = allocations.side_code
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
				allocations.account_id = @account_id and
				allocations.settlement_currency_id = @currency_code and
				ticket.settlement_date >= @from_date and
				ticket.settlement_date <= @end_date and
				ticket.ticket_type_code = 7 and
				ticket.deleted = 0 and
				allocations.primary_confirmed = 0 and
				allocations.primary_pending = 0 and 
				allocations.deleted = 0 
			option (keepfixed plan);
			insert into #driver_gcmd
			(
				account_id,
				currency_code,
				security_id,
				ticket_type_code,
				quantity,
				effective_date,
				ccy_mvmt_type_code,
				multiplier_sign,
				side_code,
				price,
				pricing_factor,
				principal_factor,
				share_indicator,
				contract_size,
				commission,
				trade_status
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
				@unconfirmed_settle_mvmt,
				side.market_value_sign,
				allocations.side_code,
				case
					when coalesce(positions.quantity, 0) = 0
						then allocations.price
						else allocations.price - ((positions.quantity * coalesce(positions.last_mark, positions.unit_cost, 0) + coalesce(#opening_alloc_totals.total_opening_alloc_cost, 0)) / (coalesce(#opening_alloc_totals.total_opening_alloc_quantity, 0) + positions.quantity))
					end,
				security.pricing_factor,
				security.principal_factor,
				side.share_indicator,
				security.contract_size,
				allocations.commission + allocations.taxes + allocations.other_charges + allocations.local_commission + allocations.exchange_fee + allocations.stamp_tax + allocations.levy + allocations.other_taxes_fees,
				@modified
			from 
				allocations
				join ticket
					on ticket.ticket_id = allocations.ticket_id
				join side
					on side.side_code = allocations.side_code
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
				allocations.account_id = @account_id and
				allocations.settlement_currency_id = @currency_code and
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
			insert into #driver_gcmd
			(
				account_id,
				currency_code,
				security_id,
				quantity,
				effective_date,
				ccy_mvmt_type_code,
				multiplier_sign,
				side_code,
				price,
				trade_status,
				cm_user_field_1,
				cm_user_field_2,
				cm_user_field_3,
				cm_user_field_4,
				cm_user_field_5,
				cm_user_field_6,
				cm_user_field_7,
				cm_user_field_8
			)
			select
				currency_movement.account_id,
				currency_movement.currency_code,
				currency_movement.security_id,
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
				currency_movement.ccy_mvmt_type_code,
				side.market_value_sign,
				side.side_code,
				1,
				@modified,
				currency_movement.user_field_1,
				currency_movement.user_field_2,
				currency_movement.user_field_3,
				currency_movement.user_field_4,
				currency_movement.user_field_5,
				currency_movement.user_field_6,
				currency_movement.user_field_7,
				currency_movement.user_field_8
			from 
				currency_movement
				join side
					on currency_movement.side_code = side.side_code
				join ticket 
					on currency_movement.ticket_id = ticket.ticket_id
				join security
					on currency_movement.security_id = security.security_id
				join currency
					on ticket.settlement_currency_id = currency.security_id
				left outer join cross_currency
					on security.principal_currency_id = cross_currency.principal_currency_id 
					and ticket.settlement_currency_id = cross_currency.counter_currency_id
				left outer join cross_currency cross_currency_inverted
					on security.principal_currency_id = cross_currency_inverted.counter_currency_id
					and ticket.settlement_currency_id = cross_currency_inverted.principal_currency_id
			where 
				ccy_mvmt_type_code = @confirmed_settle_mvmt and
				currency_movement.account_id = @account_id and
				currency_movement.currency_code = @currency_code and
				currency_movement.primary_canceled = 0 and
				currency_movement.ticket_type_code not in (12, 8, 7) and
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
		end else if @ordered_future_flag = 1 begin
			insert into #driver_gcmd
			(
				account_id,
				currency_code,
				security_id,
				quantity,
				effective_date,
				ccy_mvmt_type_code,
				multiplier_sign,
				side_code,
				price,
				trade_status,
				cm_user_field_1,
				cm_user_field_2,
				cm_user_field_3,
				cm_user_field_4,
				cm_user_field_5,
				cm_user_field_6,
				cm_user_field_7,
				cm_user_field_8
			)
			select
				currency_movement.account_id,
				currency_movement.currency_code,
				currency_movement.security_id,
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
				currency_movement.ccy_mvmt_type_code,
				side.market_value_sign,
				side.side_code,
				1,
				@modified,
				currency_movement.user_field_1,
				currency_movement.user_field_2,
				currency_movement.user_field_3,
				currency_movement.user_field_4,
				currency_movement.user_field_5,
				currency_movement.user_field_6,
				currency_movement.user_field_7,
				currency_movement.user_field_8
			from 
				currency_movement
				join side
					on currency_movement.side_code = side.side_code
				join ticket 
					on currency_movement.ticket_id = ticket.ticket_id
				join security
					on currency_movement.security_id = security.security_id
				join currency
					on ticket.settlement_currency_id = currency.security_id
				left outer join cross_currency
					on security.principal_currency_id = cross_currency.principal_currency_id 
					and ticket.settlement_currency_id = cross_currency.counter_currency_id
				left outer join cross_currency cross_currency_inverted
					on security.principal_currency_id = cross_currency_inverted.counter_currency_id
					and ticket.settlement_currency_id = cross_currency_inverted.principal_currency_id
			where 
				ccy_mvmt_type_code = @confirmed_settle_mvmt and
				currency_movement.account_id = @account_id and
				currency_movement.currency_code = @currency_code and
				currency_movement.side_code = side.side_code and
				currency_movement.primary_canceled = 0 and
				currency_movement.ticket_type_code not in (12, 8) and
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
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			ccy_mvmt_type_code,
			multiplier_sign,
			side_code,
			price
		)
		select 
			allocations.account_id,
			security.principal_currency_id,
			allocations.security_id,
			allocations.quantity,
			ticket.settlement_date,
			@unconfirmed_spot_mvmt,
			side.security_sign,
			allocations.side_code,
			1
		from 
			allocations,
			ticket,
			side,
			security
		where 
			allocations.account_id = @account_id and
			allocations.security_id = security.security_id and
			security.principal_currency_id = @currency_code and
			allocations.ticket_id = ticket.ticket_id and
			ticket.settlement_date >= @from_date and
			ticket.settlement_date <= @end_date and
			ticket.ticket_type_code in (12, 8) and
			allocations.side_code = side.side_code and
			ticket.deleted = 0 and
			allocations.primary_confirmed = 0 and
			allocations.deleted = 0  and
			allocations.primary_pending = 0 
		option (keepfixed plan);
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			ccy_mvmt_type_code,
			multiplier_sign,
			side_code,
			price
		)
		select 
			allocations.account_id,
			allocations.settlement_currency_id, 
			allocations.security_id, 
			allocations.net_amount,
			ticket.settlement_date,
			@unconfirmed_cash_mvmt,
			side.market_value_sign,
			allocations.side_code,
			1
		from 
			allocations,
			ticket,
			side
		where 
			allocations.account_id = @account_id and
			allocations.settlement_currency_id = @currency_code and  
			allocations.ticket_id = ticket.ticket_id and
			ticket.settlement_date >= @from_date and
			ticket.settlement_date <= @end_date and
			ticket.ticket_type_code in (12, 8) and
			allocations.side_code = side.side_code and
			ticket.deleted = 0 and
			allocations.primary_confirmed = 0 and
			allocations.deleted = 0 and
			allocations.primary_pending = 0 
		option (keepfixed plan);
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			ccy_mvmt_type_code,
			multiplier_sign,
			side_code,
			price,
			trade_status
		)
		select 
			allocations.account_id,
			security.principal_currency_id,
			allocations.security_id,
			allocations.quantity,
			ticket.settlement_date,
			@unconfirmed_spot_mvmt,
			side.security_sign,
			allocations.side_code,
			1,
			@modified
		from 
			allocations,
			ticket,
			side,
			security
		where 
			allocations.account_id = @account_id and
			allocations.security_id = security.security_id and
			security.principal_currency_id = @currency_code and
			allocations.ticket_id = ticket.ticket_id and
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
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			ccy_mvmt_type_code,
			multiplier_sign,
			side_code,
			price,
			trade_status
		)
		select 
			allocations.account_id,
			allocations.settlement_currency_id, 
			allocations.security_id, 
			allocations.net_amount,
			ticket.settlement_date,
			@unconfirmed_cash_mvmt,
			side.market_value_sign,
			allocations.side_code,
			1,
			@modified
		from 
			allocations,
			ticket,
			side
		where 
			allocations.account_id = @account_id and
			allocations.settlement_currency_id = @currency_code and  
			allocations.ticket_id = ticket.ticket_id and
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
	end; 
	if exists(
		select 1 
		from #user_ccy_mvmt_type 
		where ccy_mvmt_type_code = @confirmed_spot_mvmt
	) begin
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			ccy_mvmt_type_code,
			multiplier_sign,
			side_code,
			price,
			cm_user_field_1,
			cm_user_field_2,
			cm_user_field_3,
			cm_user_field_4,
			cm_user_field_5,
			cm_user_field_6,
			cm_user_field_7,
			cm_user_field_8
		)
		select 
			currency_movement.account_id,
			security.principal_currency_id,
			security.security_id,
			currency_movement.alloc_qty,
			currency_movement.effective_date,
			@confirmed_spot_mvmt,
			side.security_sign,
			currency_movement.side_code,
			1,
			currency_movement.user_field_1,
			currency_movement.user_field_2,
			currency_movement.user_field_3,
			currency_movement.user_field_4,
			currency_movement.user_field_5,
			currency_movement.user_field_6,
			currency_movement.user_field_7,
			currency_movement.user_field_8
		from 
			currency_movement,
			security,
			side
		where 
			currency_movement.account_id = @account_id and
			currency_movement.security_id = security.security_id and
			security.principal_currency_id = @currency_code and
			currency_movement.side_code = side.side_code and
			currency_movement.ticket_type_code in (12, 8) and
			currency_movement.primary_canceled = 0 and
			currency_movement.effective_date >= @from_date and
			currency_movement.effective_date <= @end_date  and not exists
				(select 1 
				from allocations 
				where 
					currency_movement.ticket_id = allocations.ticket_id and
					currency_movement.order_id = allocations.order_id and
					allocations.deleted = 0 and
					((allocations.primary_confirmed = 1 and allocations.modified = 1) or
					(allocations.primary_pending = 1 and allocations.modified = 0)))
		option (keepfixed plan);
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			ccy_mvmt_type_code,
			multiplier_sign,
			side_code,
			price,
			cm_user_field_1,
			cm_user_field_2,
			cm_user_field_3,
			cm_user_field_4,
			cm_user_field_5,
			cm_user_field_6,
			cm_user_field_7,
			cm_user_field_8
		)
		select 
			currency_movement.account_id,
			currency_movement.currency_code,
			security.security_id,
			currency_movement.quantity,
			currency_movement.effective_date,
			@confirmed_spot_cash_mvmt,
			side.market_value_sign,
			currency_movement.side_code,
			1,
			currency_movement.user_field_1,
			currency_movement.user_field_2,
			currency_movement.user_field_3,
			currency_movement.user_field_4,
			currency_movement.user_field_5,
			currency_movement.user_field_6,
			currency_movement.user_field_7,
			currency_movement.user_field_8
		from 
			currency_movement,
			security,
			side
		where 
			currency_movement.account_id = @account_id and
			currency_movement.security_id = security.security_id and
			currency_movement.currency_code = @currency_code and
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
					(allocations.primary_pending = 1 and allocations.modified = 0)))
		option (keepfixed plan);
	end; 
	if @ordered_equity_flag = 1
	begin
		insert into #alloc_qty_gcmd 
		(
			account_id, 
			allocations_qty,
			ticket_type_code,
			security_id,
			principal_currency_id,
			side_code
		)
		select 
			@account_id,
			case
				when side.share_indicator = 1
					then coalesce(sum(allocations.quantity), 0)
				else coalesce(sum(allocations.net_amount), 0)
				end,
			1,
			allocations.security_id,
			@currency_code,
			allocations.side_code
		from 
			allocations,
			orders,
			security,
			side
		where 
			orders.account_id = @account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 1 and
			security.principal_currency_id = @currency_code and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0  and
			allocations.side_code = side.side_code
		 group by 
	 		allocations.security_id,
			allocations.side_code,
			side.share_indicator
		 option (keepfixed plan);
	   	insert into #ordered_driver
		(
			account_id,
			security_id,
			effective_date,
			exchange_country_code,
			currency_code,
			quantity,
			multiplier_sign,
			side_code,
			price,
			ticket_type_code,
			pricing_factor,
			principal_factor,
			accrued_income,
			share_indicator
		)
		select  
			orders.account_id,
			orders.security_id,
			orders.settlement_date,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then sum(orders.quantity - orders.quantity_closed) - coalesce(#alloc_qty_gcmd.allocations_qty, 0)
				else 
					case
						when sum(orders.market_value - orders.market_value_closed) - coalesce(#alloc_qty_gcmd.allocations_qty / currency.exchange_rate, 0) > 0
						then sum(orders.market_value - orders.market_value_closed) - coalesce(#alloc_qty_gcmd.allocations_qty / currency.exchange_rate, 0)
						else 0
					end
				end,
			side.market_value_sign,
			side.side_code,
			price.latest,
			orders.ticket_type_code,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			side.share_indicator
		from
			orders
			join security on orders.security_id = security.security_id
			join currency on security.principal_currency_id = currency.security_id
			join exchange on security.exchange_code = exchange.exchange_code
			join side on orders.side_code = side.side_code
			join price on security.security_id = price.security_id
			left outer join #alloc_qty_gcmd
				on security.security_id = #alloc_qty_gcmd.security_id and
				   orders.account_id = #alloc_qty_gcmd.account_id and
				   orders.ticket_type_code = #alloc_qty_gcmd.ticket_type_code and
				   orders.side_code = #alloc_qty_gcmd.side_code and
				   security.principal_currency_id = #alloc_qty_gcmd.principal_currency_id
		where
			orders.account_id = @account_id and
			orders.ticket_type_code = 1 and
			orders.deleted = 0 and
			security.principal_currency_id = @currency_code and
			security.deleted = 0
		group by
			orders.account_id,
			orders.security_id,
			orders.settlement_date,
			exchange.country_code,
			security.principal_currency_id,
			side.market_value_sign,
			side.side_code,
			price.latest,
			orders.ticket_type_code,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			#alloc_qty_gcmd.allocations_qty,
			side.share_indicator,
			currency.exchange_rate
		option (keepfixed plan);
	end; 
	if @ordered_equity_ipo_flag = 1
	begin
		insert into #alloc_qty_gcmd 
		(
			account_id, 
			allocations_qty,
			ticket_type_code,
			security_id,
			principal_currency_id,
			side_code
		)
		select 
			@account_id,
			case
				when side.share_indicator = 1
					then coalesce(sum(allocations.quantity), 0)
				else coalesce(sum(allocations.net_amount), 0)
				end,
			2,
			allocations.security_id,
			@currency_code,
			allocations.side_code
		from 
			allocations,
			orders,
			security,
			side
		where
		 	orders.account_id = @account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
		    orders.ticket_type_code = 2 and
			security.principal_currency_id = @currency_code and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0 and
			allocations.side_code = side.side_code
		group by 
	 		allocations.security_id,
			allocations.side_code,
			side.share_indicator
		 option (keepfixed plan);
		insert into #ordered_driver
		(
			account_id,
			security_id,
			effective_date,
			exchange_country_code,
			currency_code,
			quantity,
			multiplier_sign,
			side_code,
			price,
			ticket_type_code,
			pricing_factor,
			principal_factor,
			accrued_income,
			share_indicator
		) 
		select 
			orders.account_id,
			orders.security_id,
			orders.settlement_date,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then sum(orders.quantity - orders.quantity_closed) - coalesce(#alloc_qty_gcmd.allocations_qty, 0)
				else 
					case
						when sum(orders.market_value - orders.market_value_closed) - coalesce(#alloc_qty_gcmd.allocations_qty / currency.exchange_rate, 0) > 0
						then sum(orders.market_value - orders.market_value_closed) - coalesce(#alloc_qty_gcmd.allocations_qty / currency.exchange_rate, 0)
						else 0
					end
				end,
			side.market_value_sign,
			side.side_code,
			price.latest,
			orders.ticket_type_code,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			side.share_indicator
		from
			orders
			join security on orders.security_id = security.security_id
			join currency on security.principal_currency_id = currency.security_id
			join exchange on security.exchange_code = exchange.exchange_code
			join side on orders.side_code = side.side_code
			join price on security.security_id = price.security_id
			left outer join #alloc_qty_gcmd
				on security.security_id = #alloc_qty_gcmd.security_id and
				   orders.account_id = #alloc_qty_gcmd.account_id and
				   orders.ticket_type_code = #alloc_qty_gcmd.ticket_type_code and
				   orders.side_code = #alloc_qty_gcmd.side_code and
				   security.principal_currency_id = #alloc_qty_gcmd.principal_currency_id
		where
			orders.account_id = @account_id and
			orders.ticket_type_code = 2 and
			orders.deleted = 0 and
			security.principal_currency_id = @currency_code and
			security.deleted = 0
		group by
			orders.account_id,
			orders.security_id,
			orders.settlement_date,
			exchange.country_code,
			security.principal_currency_id,
			side.market_value_sign,
			side.side_code,
			price.latest,
			orders.ticket_type_code,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			#alloc_qty_gcmd.allocations_qty,
			side.share_indicator,
			currency.exchange_rate
		option (keepfixed plan);
	end; 
	if @ordered_eqty_sec_off_flag = 1
	begin
		insert into #alloc_qty_gcmd 
		(
			account_id, 
			allocations_qty,
			ticket_type_code,
			security_id,
			principal_currency_id,
			side_code
		)
		select 
			@account_id,
			case
				when side.share_indicator = 1
					then coalesce(sum(allocations.quantity), 0)
				else coalesce(sum(allocations.net_amount), 0)
				end,
			3,
			allocations.security_id,
			@currency_code,
			allocations.side_code
		from 
			allocations,
			orders,
			security,
			side
		where 
			orders.account_id = @account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 3 and
			security.principal_currency_id = @currency_code and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0 and
			allocations.side_code = side.side_code
		 group by 
			allocations.security_id,
			allocations.side_code,
			side.share_indicator
		 option (keepfixed plan);
		insert into #ordered_driver
		(
			account_id,
			security_id,
			effective_date,
			exchange_country_code,
			currency_code,
			quantity,
			multiplier_sign,
			side_code,
			price,
			ticket_type_code,
			pricing_factor,
			principal_factor,
			accrued_income,
			share_indicator
		)
		select 
			orders.account_id,
			orders.security_id,
			orders.settlement_date,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then sum(orders.quantity - orders.quantity_closed) - coalesce(#alloc_qty_gcmd.allocations_qty, 0)
				else
					case
						when sum(orders.market_value - orders.market_value_closed) - coalesce(#alloc_qty_gcmd.allocations_qty / currency.exchange_rate, 0) > 0
						then sum(orders.market_value - orders.market_value_closed) - coalesce(#alloc_qty_gcmd.allocations_qty / currency.exchange_rate, 0)
						else 0
					end
				end,
			side.market_value_sign,
			side.side_code,
			price.latest,
			orders.ticket_type_code,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			side.share_indicator
		from
			orders
			join security on orders.security_id = security.security_id
			join currency on security.principal_currency_id = currency.security_id
			join exchange on security.exchange_code = exchange.exchange_code
			join side on orders.side_code = side.side_code
			join price on security.security_id = price.security_id
			left outer join #alloc_qty_gcmd
				on security.security_id = #alloc_qty_gcmd.security_id and
				   orders.account_id = #alloc_qty_gcmd.account_id and
				   orders.ticket_type_code = #alloc_qty_gcmd.ticket_type_code and
				   orders.side_code = #alloc_qty_gcmd.side_code and
				   security.principal_currency_id = #alloc_qty_gcmd.principal_currency_id
		where
			orders.account_id = @account_id and
			orders.ticket_type_code = 3 and
			orders.deleted = 0 and
			security.principal_currency_id = @currency_code and
			security.deleted = 0
		group by
			orders.account_id,
			orders.security_id,
			orders.settlement_date,
			exchange.country_code,
			security.principal_currency_id,
			side.market_value_sign,
			side.side_code,
			price.latest,
			orders.ticket_type_code,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			#alloc_qty_gcmd.allocations_qty,
			side.share_indicator,
			currency.exchange_rate
		option (keepfixed plan);
	end; 
	if @ordered_debt_flag = 1
	begin
		insert into #alloc_qty_gcmd 
		(
			account_id, 
			allocations_qty,
			ticket_type_code,
			security_id,
			principal_currency_id,
			side_code,
			settlement_date,
			allocated_accrued
		)
		select 
			@account_id,
			case
				when side.share_indicator = 1
					then coalesce(sum(allocations.quantity), 0)
				else coalesce(sum(allocations.net_amount), 0)
				end,
			orders.ticket_type_code,
			allocations.security_id,
			@currency_code,
			allocations.side_code,
			orders.settlement_date,
			coalesce(sum(allocations.accrued_income), 0)
		from 
			allocations,
			orders,
			security,
			side
		where 	
			orders.account_id = @account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code in (5, 13) and
			security.principal_currency_id = @currency_code and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			orders.settlement_date >= @from_date and
			orders.settlement_date <= @end_date and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0 and
			allocations.side_code = side.side_code
		group by 
			allocations.security_id,
			allocations.side_code,
			orders.ticket_type_code,
			orders.settlement_date,
			side.share_indicator
		option (keepfixed plan);
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			multiplier_sign,
			side_code,
			price,
			order_type,
			ticket_type_code,
			pricing_factor,
			principal_factor,
			accrued_income,
			share_indicator
		)
		select 
			orders.account_id,
			security.principal_currency_id,
			security.security_id,
			case
				when side.share_indicator = 1
					then sum(orders.quantity - orders.quantity_closed) - coalesce(#alloc_qty_gcmd.allocations_qty, 0)
				else 
					case
						when sum(orders.market_value - orders.market_value_closed) - coalesce(#alloc_qty_gcmd.allocations_qty / currency.exchange_rate, 0) > 0
						then sum(orders.market_value - orders.market_value_closed) - coalesce(#alloc_qty_gcmd.allocations_qty / currency.exchange_rate, 0)
						else 0
					end
				end,
			orders.settlement_date,
			side.market_value_sign,
			side.side_code,
			price.latest,
			@ordered,
			orders.ticket_type_code,
			security.pricing_factor,
			security.principal_factor,
			sum(orders.accrued_income) - coalesce(#alloc_qty_gcmd.allocated_accrued, 0),
			side.share_indicator
		from
			orders
			join security on orders.security_id = security.security_id
			join currency on security.principal_currency_id = currency.security_id
			join price on security.security_id = price.security_id
			join side on orders.side_code = side.side_code
			left outer join #alloc_qty_gcmd
				on security.security_id = #alloc_qty_gcmd.security_id and
				   orders.account_id = #alloc_qty_gcmd.account_id and
				   orders.ticket_type_code = #alloc_qty_gcmd.ticket_type_code and
				   orders.side_code = #alloc_qty_gcmd.side_code and
				   orders.settlement_date = #alloc_qty_gcmd.settlement_date and
				   security.principal_currency_id = #alloc_qty_gcmd.principal_currency_id
		where
			orders.account_id = @account_id and
			orders.ticket_type_code in (5, 13) and
			orders.deleted = 0 and
			orders.settlement_date >= @from_date and
			orders.settlement_date <= @end_date and
			security.principal_currency_id = @currency_code and
			security.deleted = 0
		group by
			orders.account_id,
			security.principal_currency_id,
			security.security_id,
			orders.settlement_date,
			side.market_value_sign,
			side.side_code,
			price.latest,
			orders.ticket_type_code,
			security.pricing_factor,
			security.principal_factor,
			#alloc_qty_gcmd.allocations_qty,
			#alloc_qty_gcmd.allocated_accrued,
			side.share_indicator,
			currency.exchange_rate
		option (keepfixed plan);
	end; 
	if @ordered_fund_flag = 1
	begin
		insert into #alloc_qty_gcmd 
		(
			account_id, 
			allocations_qty,
			ticket_type_code,
			security_id,
			principal_currency_id,
			side_code 
		)
		select 
			@account_id,
			case
				when side.share_indicator = 1
					then coalesce(sum(allocations.quantity), 0)
				else coalesce(sum(allocations.net_amount), 0)
				end,
			6,
			allocations.security_id,
			@currency_code,
			allocations.side_code
		from 
			allocations,
			orders,
			security,
			side
		where
		 	orders.account_id = @account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 6 and
			security.principal_currency_id = @currency_code and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0 and
			allocations.side_code = side.side_code
		group by 
			allocations.security_id,
			allocations.side_code,
			side.share_indicator
		option (keepfixed plan);
		insert into #ordered_driver
		(
			account_id,
			security_id,
			effective_date,
			exchange_country_code,
			currency_code,
			quantity,
			multiplier_sign,
			side_code,
			price,
			ticket_type_code,
			pricing_factor,
			principal_factor,
			accrued_income,
			share_indicator
		)
		select 
			orders.account_id,
			orders.security_id,
			orders.settlement_date,
			coalesce(exchange.country_code, security.country_code ),
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then sum(orders.quantity - orders.quantity_closed) - coalesce(#alloc_qty_gcmd.allocations_qty, 0)
				else 
					case 
						 when sum(orders.market_value - orders.market_value_closed) - coalesce(#alloc_qty_gcmd.allocations_qty / currency.exchange_rate, 0) > 0
						 then sum(orders.market_value - orders.market_value_closed) - coalesce(#alloc_qty_gcmd.allocations_qty / currency.exchange_rate, 0)
						 else 0	
					end
				end,
			side.market_value_sign,
			side.side_code,
			price.latest,
			orders.ticket_type_code,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			side.share_indicator
		from
			orders
			join security on orders.security_id = security.security_id
			join currency on security.principal_currency_id = currency.security_id
			left outer join exchange on security.exchange_code = exchange.exchange_code
			join side on orders.side_code = side.side_code
			join price on security.security_id = price.security_id
			left outer join #alloc_qty_gcmd
				on security.security_id = #alloc_qty_gcmd.security_id and
				   orders.account_id = #alloc_qty_gcmd.account_id and
				   orders.ticket_type_code = #alloc_qty_gcmd.ticket_type_code and
				   orders.side_code = #alloc_qty_gcmd.side_code and
				   security.principal_currency_id = #alloc_qty_gcmd.principal_currency_id
		where
			orders.account_id = @account_id and
			orders.ticket_type_code = 6 and
			orders.deleted = 0 and
			security.principal_currency_id = @currency_code and
			security.deleted = 0
		group by
			orders.account_id,
			orders.security_id,
			orders.settlement_date,
			coalesce(exchange.country_code, security.country_code),
			security.principal_currency_id,
			side.market_value_sign,
			side.side_code,
			price.latest,
			orders.ticket_type_code,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			#alloc_qty_gcmd.allocations_qty,
			side.share_indicator,
			currency.exchange_rate
		option (keepfixed plan);
	end;
	if @ordered_future_flag = 1
	begin
		insert into #alloc_qty_gcmd 
		(
			account_id, 
			allocations_qty,
			ticket_type_code,
			security_id,
			principal_currency_id,
			side_code
		)
		select 
			@account_id,
			case
				when side.buy_indicator = 1
					then 0
				when side.share_indicator = 1
					then coalesce(sum(allocations.quantity), 0)
				else coalesce(sum(allocations.net_amount), 0)
				end,
			7,
			allocations.security_id,
			@currency_code,
			allocations.side_code
		from 
			allocations,
			orders,
			security,
			side
		where 	
			orders.account_id = @account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 7 and
			security.principal_currency_id = @currency_code and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0 and
			allocations.side_code = side.side_code
		group by 
			allocations.security_id,
			allocations.side_code,
			side.share_indicator,
			side.buy_indicator
		option (keepfixed plan);
		insert into #ordered_driver
		(
			account_id,
			security_id,
			effective_date,
			exchange_country_code,
			currency_code,
			quantity,
			multiplier_sign,
			side_code,
			price,
			ticket_type_code,
			pricing_factor,
			principal_factor,
			accrued_income,
			share_indicator,
			contract_size
		)
		select 
			orders.account_id,
			orders.security_id,
			orders.settlement_date,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.buy_indicator = 1
					then 0
				when side.share_indicator = 1
					then sum(orders.quantity - orders.quantity_closed) - coalesce(#alloc_qty_gcmd.allocations_qty, 0)
				else
					case 
						when sum(orders.market_value - orders.market_value_closed) - coalesce(#alloc_qty_gcmd.allocations_qty / currency.exchange_rate, 0) > 0
						then sum(orders.market_value - orders.market_value_closed) - coalesce(#alloc_qty_gcmd.allocations_qty / currency.exchange_rate, 0)
						else 0
					end
				end,
			side.market_value_sign,
			side.side_code,
			case
				when positions.last_mark is not null
					then price.latest-positions.last_mark
				when positions.unit_cost is not null
					then price.latest-positions.unit_cost
				else price.latest
				end,
			orders.ticket_type_code,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			side.share_indicator,
			security.contract_size
		from
			orders
			join security on orders.security_id = security.security_id
			join currency on security.principal_currency_id = currency.security_id
			join exchange on security.exchange_code = exchange.exchange_code
			join side on side.side_code = orders.side_code
			join price on security.security_id = price.security_id
			left outer join positions
				on positions.account_id = @account_id
				and positions.security_id = security.security_id
				and positions.position_type_code = side.position_type_code
			left outer join #alloc_qty_gcmd
				on security.security_id = #alloc_qty_gcmd.security_id and
				   orders.account_id = #alloc_qty_gcmd.account_id and
				   orders.ticket_type_code = #alloc_qty_gcmd.ticket_type_code and
				   orders.side_code = #alloc_qty_gcmd.side_code and
				   security.principal_currency_id = #alloc_qty_gcmd.principal_currency_id
		where
			orders.account_id = @account_id and
			orders.ticket_type_code = 7 and
			orders.deleted = 0 and
			security.principal_currency_id = @currency_code and
			security.deleted = 0
		group by
			orders.account_id,
			orders.security_id,
			orders.settlement_date,
			exchange.country_code,
			security.principal_currency_id,
			side.market_value_sign,
			side.side_code,
			price.latest,
			orders.ticket_type_code,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			#alloc_qty_gcmd.allocations_qty,
			side.share_indicator,
			side.buy_indicator,
			security.contract_size,
			positions.last_mark,
			positions.unit_cost,
			currency.exchange_rate
		option (keepfixed plan);
	end; 
	if @ordered_forward_flag = 1
	begin
		insert into #alloc_qty_gcmd 
		(
			account_id, 
			allocations_qty,
			ticket_type_code,
			security_id,
			principal_currency_id,
			side_code
		)
		select 
			@account_id,
			coalesce(sum(allocations.quantity), 0),
			8,
			allocations.security_id,
			@currency_code,
			allocations.side_code
		from 
			allocations,
			orders,
			security
		where 	
			orders.account_id = @account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 8 and
			orders.settlement_date >= @from_date and
			orders.settlement_date <= @end_date and
			security.principal_currency_id = @currency_code and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0
		group by 
			allocations.security_id,
			allocations.side_code
		option (keepfixed plan);
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			multiplier_sign,
			side_code,
			price,
			order_type,
			ticket_type_code
		)
		select 
			orders.account_id,
			security.principal_currency_id,
			security.security_id,
			sum(orders.quantity) - sum(orders.quantity_closed) - coalesce(#alloc_qty_gcmd.allocations_qty, 0),
			orders.settlement_date,
			side.security_sign,
			side.side_code,
			1,
			@ordered,
			orders.ticket_type_code
		from
			orders
			join security on orders.security_id = security.security_id
			join side on orders.side_code = side.side_code
			left outer join #alloc_qty_gcmd
				on security.security_id = #alloc_qty_gcmd.security_id and
				   orders.account_id = #alloc_qty_gcmd.account_id and
				   orders.ticket_type_code = #alloc_qty_gcmd.ticket_type_code and
				   orders.side_code = #alloc_qty_gcmd.side_code and
				   security.principal_currency_id = #alloc_qty_gcmd.principal_currency_id
		where
			orders.account_id = @account_id and
			orders.ticket_type_code = 8 and
			orders.deleted = 0 and
			security.principal_currency_id = @currency_code and
			orders.settlement_date >= @from_date and
			orders.settlement_date <= @end_date and
			security.deleted = 0
		group by
			orders.account_id,
			security.principal_currency_id,
			security.security_id,
			orders.settlement_date,
			side.security_sign,
			side.side_code,
			orders.ticket_type_code,
			#alloc_qty_gcmd.allocations_qty
		option (keepfixed plan);
		delete 
		from #alloc_qty_gcmd 
		where ticket_type_code = 8  
		option (keepfixed plan);
		insert into #alloc_qty_gcmd 
		(
			account_id, 
			allocations_qty,
			ticket_type_code,
			security_id,
			principal_currency_id,
			side_code
		)
		select 
			@account_id,
			coalesce(sum(allocations.quantity), 0),
			8,
			allocations.security_id,
			@currency_code,
			allocations.side_code
		from 
			allocations,
			orders,
			security
		where 	
			orders.account_id = @account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 8 and
			orders.settlement_date >= @from_date and
			orders.settlement_date <= @end_date and
			security.settlement_currency_id = @currency_code and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0
		group by 
			allocations.security_id,
			allocations.side_code
		option (keepfixed plan);
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			multiplier_sign,
			side_code,
			price,
			order_type
		)
		select 
			orders.account_id,
			security.settlement_currency_id,
			security.security_id,
			sum(orders.quantity) - sum(orders.quantity_closed) - coalesce(#alloc_qty_gcmd.allocations_qty, 0),
			orders.settlement_date,
			side.market_value_sign, 
			side.side_code,
			price.latest, 
			@ordered_cash
		from
			orders
			join security on orders.security_id = security.security_id
			join price on security.security_id = price.security_id
			join side on orders.side_code = side.side_code
			left outer join #alloc_qty_gcmd
				on security.security_id = #alloc_qty_gcmd.security_id and
				   orders.account_id = #alloc_qty_gcmd.account_id and
				   orders.ticket_type_code = #alloc_qty_gcmd.ticket_type_code and
				   orders.side_code = #alloc_qty_gcmd.side_code and
				   security.settlement_currency_id = #alloc_qty_gcmd.principal_currency_id
		where
			orders.account_id = @account_id and
			orders.settlement_date >= @from_date and
			orders.settlement_date <= @end_date and
			orders.ticket_type_code = 8 and
			orders.deleted = 0 and
			security.settlement_currency_id = @currency_code and
			security.deleted = 0
		group by
			orders.account_id,
			security.settlement_currency_id,
			security.security_id,
			orders.settlement_date,
			side.market_value_sign, 
			side.side_code,
			price.latest,
			#alloc_qty_gcmd.allocations_qty
		option (keepfixed plan);
	end; 
	if @ordered_option_flag = 1
	begin
		insert into #alloc_qty_gcmd 
		(
			account_id, 
			allocations_qty,
			ticket_type_code,
			security_id,
			principal_currency_id,
			side_code
		)
		select 
			@account_id,
			coalesce(sum(allocations.quantity), 0),
			9,
			allocations.security_id,
			@currency_code,
			allocations.side_code
		from 
			allocations,
			orders,
			security
		where 	
			orders.account_id = @account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 9 and
			security.principal_currency_id = @currency_code and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0
		group by 
			allocations.security_id,
			allocations.side_code
		option (keepfixed plan);
		insert into #ordered_driver
		(
			account_id,
			security_id,
			effective_date,
			exchange_country_code,
			currency_code,
			quantity,
			multiplier_sign,
			side_code,
			price,
			ticket_type_code,
			pricing_factor,
			principal_factor,
			accrued_income
		)
		select 
			orders.account_id,
			orders.security_id,
			orders.settlement_date,
			exchange.country_code,
			security.principal_currency_id,
			sum(orders.quantity) - sum(orders.quantity_closed) - coalesce(#alloc_qty_gcmd.allocations_qty, 0),
			side.market_value_sign,
			side.side_code,
			price.latest,
			orders.ticket_type_code,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income
		from
			orders
			join security on orders.security_id = security.security_id
			join exchange on security.exchange_code = exchange.exchange_code
			join side on orders.side_code = side.side_code
			join price on security.security_id = price.security_id
			left outer join #alloc_qty_gcmd
				on security.security_id = #alloc_qty_gcmd.security_id and
				   orders.account_id = #alloc_qty_gcmd.account_id and
				   orders.ticket_type_code = #alloc_qty_gcmd.ticket_type_code and
				   orders.side_code = #alloc_qty_gcmd.side_code and
				   security.principal_currency_id = #alloc_qty_gcmd.principal_currency_id
		where
			orders.account_id = @account_id and
			orders.ticket_type_code = 9 and
			orders.deleted = 0 and
			security.principal_currency_id = @currency_code and
			security.deleted = 0
		group by
			orders.account_id,
			orders.security_id,
			orders.settlement_date,
			exchange.country_code,
			security.principal_currency_id,
			side.market_value_sign,
			side.side_code,
			price.latest,
			orders.ticket_type_code,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			#alloc_qty_gcmd.allocations_qty
		option (keepfixed plan);
	end; 
	if @ordered_index_flag = 1
	begin
		insert into #alloc_qty_gcmd 
		(
			account_id, 
			allocations_qty,
			ticket_type_code,
			security_id,
			principal_currency_id,
			side_code
		)
		select 
			@account_id,
			case
				when side.share_indicator = 1
					then coalesce(sum(allocations.quantity), 0)
				else coalesce(sum(allocations.net_amount), 0)
				end,
			10,
			allocations.security_id,
			@currency_code,
			allocations.side_code
		from 
			allocations,
			orders,
			security,
			side
		where 	
			orders.account_id = @account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 10 and
			security.principal_currency_id = @currency_code and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0 and
			allocations.side_code = side.side_code
		group by 
			allocations.security_id,
			allocations.side_code,
			side.share_indicator
		option (keepfixed plan);
		insert into #ordered_driver
		(
			account_id,
			security_id,
			effective_date,
			exchange_country_code,
			currency_code,
			quantity,
			multiplier_sign,
			side_code,
			price,
			ticket_type_code,
			pricing_factor,
			principal_factor,
			accrued_income,
			share_indicator
		)
		select 
			orders.account_id,
			orders.security_id,
			orders.settlement_date,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then sum(orders.quantity - orders.quantity_closed - coalesce(#alloc_qty_gcmd.allocations_qty, 0))
				else sum(case 
							when orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmd.allocations_qty / currency.exchange_rate, 0) > 0
								then orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmd.allocations_qty / currency.exchange_rate, 0)
							else 0
							end)
				end,
			side.market_value_sign,
			side.side_code,
			price.latest,
			orders.ticket_type_code,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			side.share_indicator
		from
			orders
			join security on orders.security_id = security.security_id
			join currency on security.principal_currency_id = currency.security_id
			join exchange on security.exchange_code = exchange.exchange_code
			join side on orders.side_code = side.side_code
			join price on security.security_id = price.security_id
			left outer join #alloc_qty_gcmd
				on security.security_id = #alloc_qty_gcmd.security_id and
				   orders.account_id = #alloc_qty_gcmd.account_id and
				   orders.ticket_type_code = #alloc_qty_gcmd.ticket_type_code and
				   orders.side_code = #alloc_qty_gcmd.side_code and
				   security.principal_currency_id = #alloc_qty_gcmd.principal_currency_id
		where
			orders.account_id = @account_id and
			orders.ticket_type_code = 10 and
			orders.deleted = 0 and
			security.principal_currency_id = @currency_code and
			security.deleted = 0
		group by
			orders.account_id,
			orders.security_id,
			orders.settlement_date,
			exchange.country_code,
			security.principal_currency_id,
			side.market_value_sign,
			side.side_code,
			price.latest,
			orders.ticket_type_code,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			#alloc_qty_gcmd.allocations_qty,
			side.share_indicator
		option (keepfixed plan);
	end; 
	if @ordered_unclassified_flag = 1
	begin
		insert into #alloc_qty_gcmd 
		(
			account_id, 
			allocations_qty,
			ticket_type_code,
			security_id,
			principal_currency_id,
			side_code
		)
		select 
			@account_id,
			case
				when side.share_indicator = 1
					then coalesce(sum(allocations.quantity), 0)
				else coalesce(sum(allocations.net_amount), 0)
				end,
			11,
			allocations.security_id,
			@currency_code,
			allocations.side_code
		from 
			allocations,
			orders,
			security,
			side
		where 	
			orders.account_id = @account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 11 and
			security.principal_currency_id = @currency_code and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0 and
			allocations.side_code = side.side_code
		group by 
			allocations.security_id,
			allocations.side_code,
			side.share_indicator
		option (keepfixed plan);
		insert into #ordered_driver
		(
			account_id,
			security_id,
			effective_date,
			exchange_country_code,
			currency_code,
			quantity,
			multiplier_sign,
			side_code,
			price,
			ticket_type_code,
			pricing_factor,
			principal_factor,
			accrued_income,
			share_indicator,
			contract_size
		)
		select 
			orders.account_id,
			orders.security_id,
			orders.settlement_date,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then sum(orders.quantity - orders.quantity_closed - coalesce(#alloc_qty_gcmd.allocations_qty, 0))
				else sum(case 
							when orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmd.allocations_qty / currency.exchange_rate, 0) > 0
								then orders.market_value - orders.market_value_closed - coalesce(#alloc_qty_gcmd.allocations_qty / currency.exchange_rate, 0)
							else 0
							end)
				end,
			side.market_value_sign,
			side.side_code,
			price.latest,
			orders.ticket_type_code,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			side.share_indicator,
			security.contract_size
		from
			orders
			join security on orders.security_id = security.security_id
			join currency on security.principal_currency_id = currency.security_id
			join exchange on security.exchange_code = exchange.exchange_code
			join side on orders.side_code = side.side_code
			join price on security.security_id = price.security_id
			left outer join #alloc_qty_gcmd
				on security.security_id = #alloc_qty_gcmd.security_id and
				   orders.account_id = #alloc_qty_gcmd.account_id and
				   orders.ticket_type_code = #alloc_qty_gcmd.ticket_type_code and
				   orders.side_code = #alloc_qty_gcmd.side_code and
				   security.principal_currency_id = #alloc_qty_gcmd.principal_currency_id
		where
			orders.account_id = @account_id and
			orders.ticket_type_code = 11 and
			orders.deleted = 0 and
			security.principal_currency_id = @currency_code and
			security.deleted = 0
		group by
			orders.account_id,
			orders.security_id,
			orders.settlement_date,
			exchange.country_code,
			security.principal_currency_id,
			side.market_value_sign,
			side.side_code,
			price.latest,
			orders.ticket_type_code,
			security.pricing_factor,
			security.principal_factor,
			orders.accrued_income,
			#alloc_qty_gcmd.allocations_qty,
			side.share_indicator,
			security.contract_size
		option (keepfixed plan);
	end; 
	if @ordered_spot_flag = 1
	begin
		insert into #alloc_qty_gcmd 
		(
			account_id, 
			allocations_qty,
			ticket_type_code,
			security_id,
			principal_currency_id,
			side_code,
			settlement_date
		)
		select 
			@account_id,
			coalesce(sum(allocations.quantity), 0),
			12,
			allocations.security_id,
			@currency_code,
			allocations.side_code,
			orders.settlement_date
		from 
			allocations,
			orders,
			security
		where 	
			orders.account_id = @account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 12 and
			orders.settlement_date >= @from_date and
			orders.settlement_date <= @end_date and
			security.principal_currency_id = @currency_code and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0 
		group by 
			allocations.security_id,
			allocations.side_code,
			orders.settlement_date
		option (keepfixed plan);
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			multiplier_sign,
			side_code,
			price,
			order_type,
			ticket_type_code
		)
		select 
			orders.account_id,
			security.principal_currency_id,
			security.security_id,
			sum(orders.quantity) - sum(orders.quantity_closed) - coalesce(#alloc_qty_gcmd.allocations_qty, 0),
			orders.settlement_date,
			side.security_sign,
			side.side_code,
			1,
			@ordered,
			orders.ticket_type_code
		from
			orders
			join security on orders.security_id = security.security_id
			join side on orders.side_code = side.side_code
			left outer join #alloc_qty_gcmd
				on security.security_id = #alloc_qty_gcmd.security_id and
				   orders.account_id = #alloc_qty_gcmd.account_id and
				   orders.ticket_type_code = #alloc_qty_gcmd.ticket_type_code and
				   orders.side_code = #alloc_qty_gcmd.side_code and
				   orders.settlement_date = #alloc_qty_gcmd.settlement_date and
				   security.principal_currency_id = #alloc_qty_gcmd.principal_currency_id
		where
			orders.account_id = @account_id and
			orders.ticket_type_code = 12 and
			orders.settlement_date >= @from_date and
			orders.settlement_date <= @end_date and
			orders.deleted = 0 and
			security.principal_currency_id = @currency_code and
			security.deleted = 0
		group by
			orders.account_id,
			security.principal_currency_id,
			security.security_id,
			orders.settlement_date,
			side.security_sign,
			side.side_code,
			orders.ticket_type_code,
			#alloc_qty_gcmd.allocations_qty
		option (keepfixed plan);
		delete 
		from #alloc_qty_gcmd 
		where ticket_type_code = 12  
		option (keepfixed plan);
		insert into #alloc_qty_gcmd 
		(
			account_id, 
			allocations_qty,
			ticket_type_code,
			security_id,
			principal_currency_id,
			side_code,
			settlement_date
		)
		select 
			@account_id,
			coalesce(sum(allocations.quantity), 0),
			12,
			allocations.security_id,
			@currency_code,
			allocations.side_code,
			orders.settlement_date
		from 
			allocations,
			orders,
			security
		where 	
			orders.account_id = @account_id and
			orders.order_id = allocations.order_id and
			orders.security_id = security.security_id and
			orders.ticket_type_code = 12 and
			orders.settlement_date >= @from_date and
			orders.settlement_date <= @end_date and
			security.settlement_currency_id = @currency_code and
			allocations.deleted = 0 and
			orders.deleted = 0 and
			security.deleted = 0 and
			allocations.primary_canceled = 0 and
			allocations.quantity <> 0
		group by 
			allocations.security_id,
			allocations.side_code,
			orders.settlement_date
		option (keepfixed plan);
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			multiplier_sign,
			side_code,
			price,
			order_type
		)
		select 
			orders.account_id,
			security.settlement_currency_id,
			security.security_id,	
			sum(orders.quantity) - sum(orders.quantity_closed) - coalesce(#alloc_qty_gcmd.allocations_qty, 0),
			orders.settlement_date,
			side.market_value_sign, 
			side.side_code,
			price.latest, 
			@ordered_cash
		from
			orders
			join security on orders.security_id = security.security_id
			join price on security.security_id = price.security_id
			join side on orders.side_code = side.side_code
			left outer join #alloc_qty_gcmd
				on security.security_id = #alloc_qty_gcmd.security_id and
				   orders.account_id = #alloc_qty_gcmd.account_id and
				   orders.ticket_type_code = #alloc_qty_gcmd.ticket_type_code and
				   orders.side_code = #alloc_qty_gcmd.side_code and
				   orders.settlement_date = #alloc_qty_gcmd.settlement_date and
				   security.settlement_currency_id = #alloc_qty_gcmd.principal_currency_id
		where
			orders.account_id = @account_id and
			orders.settlement_date >= @from_date and
			orders.settlement_date <= @end_date and
			orders.ticket_type_code = 12 and
			orders.deleted = 0 and
			security.settlement_currency_id = @currency_code and
			security.deleted = 0
		group by
			orders.account_id,
			security.settlement_currency_id,
			security.security_id,
			orders.settlement_date,
			side.market_value_sign, 
			side.side_code,
			price.latest,
			#alloc_qty_gcmd.allocations_qty
		option (keepfixed plan);
	end; 
	if @ordered_equity_flag = 1 
		or @ordered_equity_ipo_flag = 1 
		or @ordered_eqty_sec_off_flag = 1
		or @ordered_fund_flag = 1 
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
		from #ordered_driver
		 where effective_date is null
		option (keepfixed plan);
		select @trade_date = @current_date;
		while exists(
			select 1
			from #ordered_settle_date_driver
		) begin
			select @security_id = min(security_id) 
			from #ordered_settle_date_driver;
			select @exchange_country_code = exchange_country_code 						
			from #ordered_settle_date_driver
			where security_id = @security_id;
			select @exchange_code = exchange_code,
				@major_asset_code = major_asset_code,
				@minor_asset_code = minor_asset_code,
				@bond_type_code = bond_type_code,
				@issuer_type_code = issuer_type_code
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
				update #ordered_driver
				set effective_date = @settlement_date
				where security_id = @security_id and
					exchange_country_code = @exchange_country_code
				option (keepfixed plan);
			end;
			delete from #ordered_settle_date_driver
			where security_id = @security_id and
				exchange_country_code = @exchange_country_code
			option (keepfixed plan);
		end;  
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			multiplier_sign,
			side_code,
			price,
			order_type,
			ticket_type_code,
			pricing_factor,
			principal_factor,
			accrued_income,
			share_indicator,
			contract_size
		)
		select 
			#ordered_driver.account_id,
			#ordered_driver.currency_code,
			#ordered_driver.security_id,
			#ordered_driver.quantity,
			#ordered_driver.effective_date,
			#ordered_driver.multiplier_sign,
			#ordered_driver.side_code,
			#ordered_driver.price,
			@ordered,
			#ordered_driver.ticket_type_code,
			#ordered_driver.pricing_factor,
			#ordered_driver.principal_factor,
			#ordered_driver.accrued_income,
			#ordered_driver.share_indicator,
			#ordered_driver.contract_size
		from 
			#ordered_driver
		where 
			#ordered_driver.effective_date >= @from_date and
			#ordered_driver.effective_date <= @end_date and
			#ordered_driver.quantity <> 0				  
		option (keepfixed plan);
	end; 
	if @proposed_equity_flag = 1
	begin
		insert into #proposed_driver_gcmd
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			multiplier_sign,
			side_code,
			price,
			ticket_type_code,
			position_type_code,
			order_id,
			override_check,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date,
			share_indicator
		)
		select 
			proposed_orders.account_id,
			proposed_orders.security_id,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then proposed_orders.quantity
				else proposed_orders.market_value
				end,
			side.market_value_sign,
			side.side_code,
			price.latest,
			proposed_orders.ticket_type_code,
			proposed_orders.position_type_code,
			proposed_orders.order_id,
			proposed_orders.override_check,
			security.pricing_factor,
			security.principal_factor,
			proposed_orders.accrued_income,
			proposed_orders.settlement_date,
			side.share_indicator
		from 
			proposed_orders,
			exchange,
			security,
			side,
			price
		where proposed_orders.account_id = @account_id 
			and	proposed_orders.security_id = security.security_id 
			and	proposed_orders.ticket_type_code = 1 
			and	proposed_orders.side_code = side.side_code 
			and	(proposed_orders.quantity <> 0.0 or proposed_orders.market_value <> 0)
			and proposed_orders.is_pre_executed = 0
			and	security.security_id = price.security_id 
			and	security.exchange_code = exchange.exchange_code 
			and	security.principal_currency_id = @currency_code 
			and	security.deleted = 0
		option (keepfixed plan);
	end;
	if @proposed_equity_ipo_flag = 1
	begin
		insert into #proposed_driver_gcmd
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			multiplier_sign,
			side_code,
			price,
			ticket_type_code,
			position_type_code,
			order_id,
			override_check,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date,
			share_indicator
		)
		select 
			proposed_orders.account_id,
			proposed_orders.security_id,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then proposed_orders.quantity
				else proposed_orders.market_value
				end,
			side.market_value_sign,
			side.side_code,
			price.latest,
			proposed_orders.ticket_type_code,
			proposed_orders.position_type_code,
			proposed_orders.order_id,
			proposed_orders.override_check,
			security.pricing_factor,
			security.principal_factor,
			proposed_orders.accrued_income,
			proposed_orders.settlement_date,
			side.share_indicator
		from 
			proposed_orders,
			exchange,
			security,
			side,
			price
		where proposed_orders.account_id = @account_id 
			and proposed_orders.security_id = security.security_id 
			and	proposed_orders.ticket_type_code = 2 
			and	proposed_orders.side_code = side.side_code 
			and	(proposed_orders.quantity <> 0.0 or proposed_orders.market_value <> 0)
			and proposed_orders.is_pre_executed = 0
			and	security.security_id = price.security_id 
			and	security.exchange_code = exchange.exchange_code 
			and	security.principal_currency_id = @currency_code 
			and	security.deleted = 0
		option (keepfixed plan);
	end;
	if @proposed_eqty_sec_off_flag = 1
	begin
		insert into #proposed_driver_gcmd
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			multiplier_sign,
			side_code,
			price,
			ticket_type_code,
			position_type_code,
			order_id,
			override_check,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date,
			share_indicator
		)
		select 
			proposed_orders.account_id,
			proposed_orders.security_id,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then proposed_orders.quantity
				else proposed_orders.market_value
				end,
			side.market_value_sign,
			side.side_code,
			price.latest,
			proposed_orders.ticket_type_code,
			proposed_orders.position_type_code,
			proposed_orders.order_id,
			proposed_orders.override_check,
			security.pricing_factor,
			security.principal_factor,
			proposed_orders.accrued_income,
			proposed_orders.settlement_date,
			side.share_indicator
		from 
			proposed_orders,
			exchange,
			security,
			side,
			price
		where proposed_orders.account_id = @account_id 
			and	proposed_orders.security_id = security.security_id 
			and	proposed_orders.ticket_type_code = 3 
			and	proposed_orders.side_code = side.side_code 
			and	(proposed_orders.quantity <> 0.0 or proposed_orders.market_value <> 0)
			and proposed_orders.is_pre_executed = 0
			and	security.security_id = price.security_id 
			and	security.exchange_code = exchange.exchange_code 
			and	security.principal_currency_id = @currency_code 
			and	security.deleted = 0
		option (keepfixed plan);
	end; 
	if @proposed_debt_flag = 1
	begin
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			multiplier_sign,
			side_code,
			price,
			order_type,
			ticket_type_code,
			position_type_code,
			order_id,
			override_check,
			pricing_factor,
			principal_factor,
			accrued_income,
			share_indicator
		)
		select 
			proposed_orders.account_id,
			security.principal_currency_id,
			security.security_id,
			case
				when side.share_indicator = 1
					then proposed_orders.quantity
				else proposed_orders.market_value
				end,
			proposed_orders.settlement_date,
			side.market_value_sign,
			side.side_code,
			price.latest,
			@proposed,
			proposed_orders.ticket_type_code,
			proposed_orders.position_type_code,
			proposed_orders.order_id,
			proposed_orders.override_check,
			security.pricing_factor,
			security.principal_factor,
			proposed_orders.accrued_income,
			side.share_indicator
		from 
			proposed_orders,
			security,
			side,
			price
		where proposed_orders.account_id = @account_id 
			and	proposed_orders.security_id = security.security_id 
			and	proposed_orders.ticket_type_code in (5, 13) 
			and	proposed_orders.side_code = side.side_code 
			and	(proposed_orders.quantity <> 0.0 or proposed_orders.market_value <> 0)
			and	proposed_orders.settlement_date >= @from_date 
			and	proposed_orders.settlement_date <= @end_date 
			and proposed_orders.is_pre_executed = 0
			and	security.security_id = price.security_id 
			and	security.principal_currency_id = @currency_code 
			and	security.deleted = 0 
		option (keepfixed plan);
	end;
	if @proposed_fund_flag = 1
	begin
		insert into #proposed_driver_gcmd
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			multiplier_sign,
			side_code,
			price,
			ticket_type_code,
			position_type_code,
			order_id,
			override_check,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date,
			share_indicator
		)
		select 
			proposed_orders.account_id,
			proposed_orders.security_id,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then proposed_orders.quantity
				else proposed_orders.market_value
				end,
			side.market_value_sign,
			side.side_code,
			price.latest,
			proposed_orders.ticket_type_code,
			proposed_orders.position_type_code,
			proposed_orders.order_id,
			proposed_orders.override_check,
			security.pricing_factor,
			security.principal_factor,
			proposed_orders.accrued_income,
			proposed_orders.settlement_date,
			side.share_indicator
		from proposed_orders
		join security 
			on proposed_orders.security_id = security.security_id
			and security.principal_currency_id = @currency_code 
			and	security.deleted = 0
		left outer join exchange 
			on security.exchange_code = exchange.exchange_code
		join side 
			on proposed_orders.side_code = side.side_code
		join price 
			on security.security_id = price.security_id
		where proposed_orders.account_id = @account_id 
			and	proposed_orders.ticket_type_code = 6 
			and	(proposed_orders.quantity <> 0.0 or proposed_orders.market_value <> 0)
			and proposed_orders.is_pre_executed = 0
		option (keepfixed plan);
	end;
	if @proposed_future_flag = 1
	begin
		insert into #proposed_driver_gcmd
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			multiplier_sign,
			side_code,
			price,
			ticket_type_code,
			position_type_code,
			order_id,
			override_check,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date,
			share_indicator,
			contract_size
		)
		select 
			proposed_orders.account_id,
			proposed_orders.security_id,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.buy_indicator = 1
					then 0
				when side.share_indicator = 1
					then proposed_orders.quantity
				else proposed_orders.market_value
				end,
			side.market_value_sign,
			side.side_code,
			case
				when positions.last_mark is not null
					then price.latest-positions.last_mark
				when positions.unit_cost is not null
					then price.latest-positions.unit_cost
				else price.latest
				end,
			proposed_orders.ticket_type_code,
			proposed_orders.position_type_code,
			proposed_orders.order_id,
			proposed_orders.override_check,
			security.pricing_factor,
			security.principal_factor,
			proposed_orders.accrued_income,
			proposed_orders.settlement_date,
			side.share_indicator,
			security.contract_size
		from 
			proposed_orders
			join security
				on security.security_id = proposed_orders.security_id
			join price
				on price.security_id = security.security_id
			join exchange
				on exchange.exchange_code = security.exchange_code
			join side
				on proposed_orders.side_code = side.side_code
			left outer join positions
				on positions.account_id = proposed_orders.account_id
				and positions.security_id = proposed_orders.security_id
				and positions.position_type_code = proposed_orders.position_type_code
		where proposed_orders.account_id = @account_id 
			and	proposed_orders.ticket_type_code = 7 
			and	(proposed_orders.quantity <> 0.0 or proposed_orders.market_value <> 0)
			and proposed_orders.is_pre_executed = 0
			and	security.principal_currency_id = @currency_code 
			and	security.deleted = 0
		option (keepfixed plan);
	end;
	if @proposed_forward_flag = 1
	begin
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			multiplier_sign,
			side_code,
			price,
			order_type,
			ticket_type_code,
			position_type_code,
			order_id,
			override_check
		)
		select 
			proposed_orders.account_id,
			security.principal_currency_id,
			security.security_id,
			proposed_orders.quantity,
			proposed_orders.settlement_date,
			side.security_sign,
			side.side_code,
			1,  
			@proposed,
			proposed_orders.ticket_type_code,
			proposed_orders.position_type_code,
			proposed_orders.order_id,
			proposed_orders.override_check
		from 
			proposed_orders,
			security,
			side
		where proposed_orders.account_id = @account_id 
			and	proposed_orders.security_id = security.security_id 
			and	proposed_orders.ticket_type_code = 8 
			and	proposed_orders.side_code = side.side_code 
			and	proposed_orders.settlement_date >= @from_date 
			and	proposed_orders.settlement_date <= @end_date 
			and	proposed_orders.quantity <> 0.0
			and proposed_orders.is_pre_executed = 0
			and	security.principal_currency_id = @currency_code 
			and	security.deleted = 0 
		option (keepfixed plan);
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			multiplier_sign,
			side_code,
			price,
			order_type
		)
		select 
			proposed_orders.account_id,
			security.settlement_currency_id,
			security.security_id,
			proposed_orders.quantity,
			proposed_orders.settlement_date,
			side.market_value_sign, 
			side.side_code,
			price.latest,
			@proposed_cash
		from 
			proposed_orders,
			security,
			side,
			price
		where proposed_orders.account_id = @account_id 
			and	proposed_orders.security_id = security.security_id 
			and	proposed_orders.ticket_type_code = 8 
			and	proposed_orders.side_code = side.side_code 
			and	proposed_orders.settlement_date >= @from_date 
			and	proposed_orders.settlement_date <= @end_date 
			and	proposed_orders.quantity <> 0.0
			and proposed_orders.is_pre_executed = 0
			and	security.security_id = price.security_id 
			and security.settlement_currency_id = @currency_code 
			and	security.deleted = 0 
		option (keepfixed plan);
	end;
	if @proposed_option_flag = 1
	begin
		insert into #proposed_driver_gcmd
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			multiplier_sign,
			side_code,
			price,
			ticket_type_code,
			position_type_code,
			order_id,
			override_check,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date
		)
		select 
			proposed_orders.account_id,
			proposed_orders.security_id,
			exchange.country_code,
			security.principal_currency_id,
			proposed_orders.quantity,
			side.market_value_sign,
			side.side_code,
			price.latest,
			proposed_orders.ticket_type_code,
			proposed_orders.position_type_code,
			proposed_orders.order_id,
			proposed_orders.override_check,
			security.pricing_factor,
			security.principal_factor,
			proposed_orders.accrued_income,
			proposed_orders.settlement_date
		from 
			proposed_orders,
			exchange,
			security,
			side,
			price
		where proposed_orders.account_id = @account_id 
			and	proposed_orders.security_id = security.security_id 
			and	proposed_orders.ticket_type_code = 9 
			and	proposed_orders.side_code = side.side_code 
			and	proposed_orders.quantity <> 0.0
			and proposed_orders.is_pre_executed = 0 
			and	security.security_id = price.security_id 
			and	security.exchange_code = exchange.exchange_code 
			and	security.principal_currency_id = @currency_code 
			and	security.deleted = 0
		option (keepfixed plan);
	end;
	if @proposed_index_flag = 1
	begin
		insert into #proposed_driver_gcmd
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			multiplier_sign,
			side_code,
			price,
			ticket_type_code,
			position_type_code,
			order_id,
			override_check,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date,
			share_indicator
		)
		select 
			proposed_orders.account_id,
			proposed_orders.security_id,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then proposed_orders.quantity
				else proposed_orders.market_value
				end,
			side.market_value_sign,
			side.side_code,
			price.latest,
			proposed_orders.ticket_type_code,
			proposed_orders.position_type_code,
			proposed_orders.order_id,
			proposed_orders.override_check,
			security.pricing_factor,
			security.principal_factor,
			proposed_orders.accrued_income,
			proposed_orders.settlement_date,
			side.share_indicator
		from 
			proposed_orders,
			exchange,
			security,
			side,
			price
		where proposed_orders.account_id = @account_id 
			and	proposed_orders.security_id = security.security_id 
			and	proposed_orders.ticket_type_code = 10 
			and	proposed_orders.side_code = side.side_code 
			and	(proposed_orders.quantity <> 0.0 or proposed_orders.market_value <> 0)
			and proposed_orders.is_pre_executed = 0
			and	security.security_id = price.security_id 
			and	security.exchange_code = exchange.exchange_code 
			and	security.principal_currency_id = @currency_code 
			and	security.deleted = 0
		option (keepfixed plan);
	end;
	if @proposed_unclassified_flag = 1
	begin
		insert into #proposed_driver_gcmd
		(
			account_id,
			security_id,
			exchange_country_code,
			currency_code,
			quantity,
			multiplier_sign,
			side_code,
			price,
			ticket_type_code,
			position_type_code,
			order_id,
			override_check,
			pricing_factor,
			principal_factor,
			accrued_income,
			effective_date,
			share_indicator,
			contract_size
		)
		select 
			proposed_orders.account_id,
			proposed_orders.security_id,
			exchange.country_code,
			security.principal_currency_id,
			case
				when side.share_indicator = 1
					then proposed_orders.quantity
				else proposed_orders.market_value
				end,
			side.market_value_sign,
			side.side_code,
			price.latest,
			proposed_orders.ticket_type_code,
			proposed_orders.position_type_code,
			proposed_orders.order_id,
			proposed_orders.override_check,
			security.pricing_factor,
			security.principal_factor,
			proposed_orders.accrued_income,
			proposed_orders.settlement_date,
			side.share_indicator,
			security.contract_size
		from 
			proposed_orders,
			exchange,
			security,
			side,
			price
		where proposed_orders.account_id = @account_id 
			and	proposed_orders.security_id = security.security_id 
			and	proposed_orders.ticket_type_code = 11 
			and	proposed_orders.side_code = side.side_code 
			and	(proposed_orders.quantity <> 0.0 or proposed_orders.market_value <> 0)
			and proposed_orders.is_pre_executed = 0
			and	security.security_id = price.security_id 
			and	security.exchange_code = exchange.exchange_code 
			and	security.principal_currency_id = @currency_code 
			and	security.deleted = 0
		option (keepfixed plan);
	end;
	if @proposed_spot_flag = 1
	begin
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			multiplier_sign,
			side_code,
			price,
			order_type,
			ticket_type_code,
			position_type_code,
			order_id,
			override_check
		)
		select 
			proposed_orders.account_id,
			security.principal_currency_id,
			security.security_id,
			proposed_orders.quantity,
			proposed_orders.settlement_date,
			side.security_sign,
			side.side_code,
			1,
			@proposed,
			proposed_orders.ticket_type_code,
			proposed_orders.position_type_code,
			proposed_orders.order_id,
			proposed_orders.override_check
		from 
			proposed_orders,
			security,
			side
		where proposed_orders.account_id = @account_id 
			and	proposed_orders.security_id = security.security_id 
			and	proposed_orders.ticket_type_code = 12 
			and	proposed_orders.side_code = side.side_code 
			and	proposed_orders.settlement_date >= @from_date 
			and	proposed_orders.settlement_date <= @end_date 
			and	proposed_orders.quantity <> 0.0
			and proposed_orders.is_pre_executed = 0
			and	security.principal_currency_id = @currency_code 
			and	security.deleted = 0 
		option (keepfixed plan);
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			multiplier_sign,
			side_code,
			price,
			order_type
		)
		select 
			proposed_orders.account_id,
			security.settlement_currency_id,
			security.security_id,
			proposed_orders.quantity,
			proposed_orders.settlement_date,
			side.market_value_sign, 
			side.side_code,
			price.latest, 
			@proposed_cash
		from 
			proposed_orders,
			security,
			side,  
			price
		where proposed_orders.account_id = @account_id 
			and	proposed_orders.security_id = security.security_id 
			and	proposed_orders.ticket_type_code = 12 
			and	proposed_orders.side_code = side.side_code 
			and	proposed_orders.settlement_date >= @from_date 
			and	proposed_orders.settlement_date <= @end_date 
			and	proposed_orders.quantity <> 0.0
			and is_pre_executed = 0 
			and	security.security_id = price.security_id 
			and	security.settlement_currency_id = @currency_code 
			and security.deleted = 0 
		option (keepfixed plan);
	end;
	if @proposed_equity_flag = 1 
		or @proposed_equity_ipo_flag = 1 
		or @proposed_eqty_sec_off_flag = 1
		or @proposed_fund_flag = 1 
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
			#proposed_driver_gcmd
		where 
			effective_date is null
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
				update #proposed_driver_gcmd
				set effective_date = @settlement_date
				where security_id = @security_id and
						exchange_country_code = @exchange_country_code;
			end;
			delete from #proposed_trade_date_driver
			where security_id = @security_id and
				  exchange_country_code = @exchange_country_code
			option (keepfixed plan);
		end; 				  		
		insert into #driver_gcmd
		(
			account_id,
			currency_code,
			security_id,
			quantity,
			effective_date,
			multiplier_sign,
			side_code,
			price,
			order_type,
			ticket_type_code,
			position_type_code,
			order_id,
			override_check,
			pricing_factor,
			principal_factor,
			accrued_income,
			share_indicator,
			contract_size
		)
		select 
			#proposed_driver_gcmd.account_id,
			#proposed_driver_gcmd.currency_code,
			#proposed_driver_gcmd.security_id,
			#proposed_driver_gcmd.quantity,
			#proposed_driver_gcmd.effective_date,
			#proposed_driver_gcmd.multiplier_sign,
			#proposed_driver_gcmd.side_code,
			#proposed_driver_gcmd.price,
			@proposed,
			#proposed_driver_gcmd.ticket_type_code,
			#proposed_driver_gcmd.position_type_code,
			#proposed_driver_gcmd.order_id,
			#proposed_driver_gcmd.override_check,
			#proposed_driver_gcmd.pricing_factor,
			#proposed_driver_gcmd.principal_factor,
			#proposed_driver_gcmd.accrued_income,
			#proposed_driver_gcmd.share_indicator,
			#proposed_driver_gcmd.contract_size
		from 
			#proposed_driver_gcmd
		where 
			#proposed_driver_gcmd.effective_date >= @from_date and
			#proposed_driver_gcmd.effective_date <= @end_date
		option (keepfixed plan);
	end; 
	insert into #final_driver_gcmd
	(
		account_id,
		currency_code,
		security_id,
		quantity,
		effective_date,
		ccy_mvmt_type_code,
		multiplier_sign,
		side_code,
		price,
		order_type,
		ticket_type_code,
		position_type_code,
		order_id,
		override_check,
		trade_status,
		cm_user_field_1,
		cm_user_field_2,
		cm_user_field_3,
		cm_user_field_4,
		cm_user_field_5,
		cm_user_field_6,
		cm_user_field_7,
		cm_user_field_8
	)
	select 
		#driver_gcmd.account_id,
		#driver_gcmd.currency_code,
		#driver_gcmd.security_id,
		case
			when #driver_gcmd.share_indicator = 0
				then #driver_gcmd.multiplier_sign 
					* sum(#driver_gcmd.quantity)
				else #driver_gcmd.multiplier_sign 
					* sum(#driver_gcmd.quantity * #driver_gcmd.price 
					* coalesce(#driver_gcmd.pricing_factor, 1) 
					* coalesce(#driver_gcmd.principal_factor, 1)
					* coalesce(#driver_gcmd.contract_size, 1)
					+ coalesce(#driver_gcmd.accrued_income, 0)
					- coalesce(#driver_gcmd.commission, 0))
				end,
		#driver_gcmd.effective_date,
		#driver_gcmd.ccy_mvmt_type_code,
		#driver_gcmd.multiplier_sign,
		#driver_gcmd.side_code,
		#driver_gcmd.price,
		#driver_gcmd.order_type,
		#driver_gcmd.ticket_type_code,
		#driver_gcmd.position_type_code,
		#driver_gcmd.order_id,
		#driver_gcmd.override_check,
		#driver_gcmd.trade_status,
		#driver_gcmd.cm_user_field_1,
		#driver_gcmd.cm_user_field_2,
		#driver_gcmd.cm_user_field_3,
		#driver_gcmd.cm_user_field_4,
		#driver_gcmd.cm_user_field_5,
		#driver_gcmd.cm_user_field_6,
		#driver_gcmd.cm_user_field_7,
		#driver_gcmd.cm_user_field_8
	from 
		#driver_gcmd
	where 
		#driver_gcmd.quantity <> 0		  
	group by 
		#driver_gcmd.account_id,
		#driver_gcmd.currency_code,
		#driver_gcmd.security_id,
		#driver_gcmd.effective_date,
		#driver_gcmd.ccy_mvmt_type_code,
		#driver_gcmd.multiplier_sign,
		#driver_gcmd.side_code,
		#driver_gcmd.price,
		#driver_gcmd.order_type,
		#driver_gcmd.ticket_type_code,
		#driver_gcmd.position_type_code,
		#driver_gcmd.order_id,
		#driver_gcmd.override_check,
		#driver_gcmd.trade_status,
		#driver_gcmd.cm_user_field_1,
		#driver_gcmd.cm_user_field_2,
		#driver_gcmd.cm_user_field_3,
		#driver_gcmd.cm_user_field_4,
		#driver_gcmd.cm_user_field_5,
		#driver_gcmd.cm_user_field_6,
		#driver_gcmd.cm_user_field_7,
		#driver_gcmd.cm_user_field_8,
		#driver_gcmd.share_indicator;
	select distinct
		account.short_name				as account_short_name,
		currency.mnemonic				as currency_mnemonic,
		security.symbol					as security_symbol,
		#final_driver_gcmd.quantity		as quantity,
		#final_driver_gcmd.effective_date	as effective_date,
		currency_movement_type.mnemonic		as ccy_mvmt_type_mnemonic,
		#final_driver_gcmd.order_type		as order_type,
		account.account_id,
		currency.security_id				as currency_id,
		#final_driver_gcmd.cm_user_field_1	as currency_movement_user_field_1,
		#final_driver_gcmd.cm_user_field_2	as currency_movement_user_field_2,
		#final_driver_gcmd.cm_user_field_3	as currency_movement_user_field_3,
		#final_driver_gcmd.cm_user_field_4	as currency_movement_user_field_4,
		#final_driver_gcmd.cm_user_field_5	as currency_movement_user_field_5,
		#final_driver_gcmd.cm_user_field_6	as currency_movement_user_field_6,
		#final_driver_gcmd.cm_user_field_7	as currency_movement_user_field_7,
		#final_driver_gcmd.cm_user_field_8	as currency_movement_user_field_8,
		#final_driver_gcmd.ccy_mvmt_type_code,
		currency.exchange_rate,
		account.user_field_1				as account_user_field_1,
		account.user_field_2				as account_user_field_2,
		account.user_field_3				as account_user_field_3,
		account.user_field_4				as account_user_field_4,
		account.user_field_5				as account_user_field_5,
		account.user_field_6				as account_user_field_6,
		account.user_field_7				as account_user_field_7,
		account.user_field_8				as account_user_field_8,
		account.user_field_9				as account_user_field_9,
		account.user_field_10				as account_user_field_10,
		account.user_field_11				as account_user_field_11,
		account.user_field_12				as account_user_field_12,
		account.user_field_13				as account_user_field_13,
		account.user_field_14				as account_user_field_14,
		account.user_field_15				as account_user_field_15,
		account.user_field_16				as account_user_field_16,
		account.user_id_1					as account_user_id_1,
		account.user_id_2					as account_user_id_2,
		account.user_id_3					as account_user_id_3,
		account.user_id_4					as account_user_id_4,
		account.user_id_5					as account_user_id_5,
		account.user_id_6					as account_user_id_6,
		account.user_id_7					as account_user_id_7,
		account.user_id_8					as account_user_id_8,
		account.user_id_9					as account_user_id_9,
		account.user_id_10					as account_user_id_10,
		account.user_id_11					as account_user_id_11,
		account.user_id_12					as account_user_id_12,
		account.user_id_13					as account_user_id_13,
		account.user_id_14					as account_user_id_14,
		account.user_id_15					as account_user_id_15,
		account.user_id_16					as account_user_id_16,
		security.user_field_1				as security_user_field_1,
		security.user_field_2				as security_user_field_2,
		security.user_field_3				as security_user_field_3,
		security.user_field_4				as security_user_field_4,
		security.user_field_5				as security_user_field_5,
		security.user_field_6				as security_user_field_6,
		security.user_field_7				as security_user_field_7,
		security.user_field_8				as security_user_field_8,
		security.user_field_9				as security_user_field_9,
		security.user_field_10				as security_user_field_10,
		security.user_field_11				as security_user_field_11,
		security.user_field_12				as security_user_field_12,
		security.user_field_13				as security_user_field_13,
		security.user_field_14				as security_user_field_14,
		security.user_field_15				as security_user_field_15,
		security.user_field_16				as security_user_field_16,
		security.user_id_1					as security_user_id_1,
		security.user_id_2					as security_user_id_2,
		security.user_id_3					as security_user_id_3,
		security.user_id_4					as security_user_id_4,
		security.user_id_5					as security_user_id_5,
		security.user_id_6					as security_user_id_6,
		security.user_id_7					as security_user_id_7,
		security.user_id_8					as security_user_id_8,
		security.user_id_9					as security_user_id_9,
		security.user_id_10					as security_user_id_10,
		security.user_id_11					as security_user_id_11,
		security.user_id_12					as security_user_id_12,
		security.user_id_13					as security_user_id_13,
		security.user_id_14					as security_user_id_14,
		security.user_id_15					as security_user_id_15,
		security.user_id_16					as security_user_id_16,
		side.side_code						as side_code,
		side.mnemonic						as side_mnemonic,
		security.security_id				as security_id,
		#final_driver_gcmd.ticket_type_code	as ticket_type_code,
		#final_driver_gcmd.position_type_code	as position_type_code,
		#final_driver_gcmd.order_id			as order_id,
		#final_driver_gcmd.override_check	as override_check,
		security.major_asset_code			as security_major_asset_code,
		account.account_level_code			as account_type_code,
		#final_driver_gcmd.trade_status		as trade_status,
		security.debt_type_code				as security_debt_type_code,
		security.security_level_code		as security_level_code
	from #final_driver_gcmd
	join account 
		on #final_driver_gcmd.account_id = account.account_id
	join currency 
		on #final_driver_gcmd.currency_code = currency.security_id
	left outer join security 
		on #final_driver_gcmd.security_id = security.security_id
		and security.deleted = 0
	left outer join currency_movement_type 
		on #final_driver_gcmd.ccy_mvmt_type_code = currency_movement_type.currency_movement_type_code
	left outer join currency_movement 
		on #final_driver_gcmd.ccy_mvmt_type_code = currency_movement.ccy_mvmt_type_code
	left outer join side 
		on #final_driver_gcmd.side_code = side.side_code
	where #final_driver_gcmd.account_id = @account_id 
		and	#final_driver_gcmd.currency_code = @currency_code 
		and	account.deleted = 0 
		and	account.disabled = 0 
		and	#final_driver_gcmd.quantity <> 0;
end



go
if @@error = 0 print 'PROCEDURE: se_get_currency_mvmt_detail created'
else print 'PROCEDURE: se_get_currency_mvmt_detail error on creation'
go
