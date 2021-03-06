if exists (select * from sysobjects where name = 'rpx_cash_balance')
begin
	drop procedure rpx_cash_balance
	print 'PROCEDURE: rpx_cash_balance dropped'
end
go
create procedure [dbo].[rpx_cash_balance]--rpx_cash_balance 10350,1,1,1,172,1
(
	@account_id					numeric(10),
	@is_account_id              smallint = 1,
	@include_negatives			smallint = 0,
	@include_positives			smallint = 0,
	@user_id					smallint,
	@currency_id				numeric(10)
)
as
	declare @sacct_id						nvarchar(40);
	declare @current_user					int;
	declare @ret_val						int;
	declare @continue_flag					int;
	declare @cps_rpx_cmpl_pre_top_act_det	nvarchar(30);
	declare @cpe_rpx_cmpl_pre_top_act_det	nvarchar(30);
	declare @exchange_rate					float;
	declare @account_name					nvarchar(40);
	declare @currency_name					nvarchar(40);
begin
                        set nocount on;
                        declare @ec__errno int;
                        declare @sp_initial_trancount int;
                        declare @sp_trancount int;
	create table #account  	(  		account_id numeric(10) not null  	);
	create table #principal_exchange_rates  	(  		security_id				numeric(10) null,  		principal_cur_id		numeric(10) null,  		principal_exchange_rate	float null	   	);
	create table #account_mkt_value  	(  		account_id				numeric(10) not null,  		account_market_value	float	null   	);
	create table #cash_balance  	(  		account_id			numeric(10)		null,  		position_id			numeric(10)		null,  		negative_cash		float		null,  		positive_cash		float		null,  		total_cash			float		null   	);
	select @continue_flag = 1
select @cps_rpx_cmpl_pre_top_act_det = sysobjects.name
from sysobjects
where
	sysobjects.name = 'cps_rpx_cmpl_pre_top_act_det'
	and sysobjects.type = 'P'
if @cps_rpx_cmpl_pre_top_act_det is not null
begin
	execute @ret_val = cps_rpx_cmpl_pre_top_act_det
		@continue_flag output, @account_id,
		@is_account_id,
		@include_negatives,
		@include_positives,
		@user_id,
		@currency_id
	if (@ret_val != 0 and @ret_val < 60000) or @continue_flag = 0
	begin
		return @ret_val
	end
end
    if (@account_id <> -1)
    begin
		if (@is_account_id <> 0)
		begin
			if (@is_account_id = 2)
			begin
				insert into #account 
				(
					account_id
				)
				values (@account_id);
				select @sacct_id = account.short_name 
				from account 
				where account.account_id = @account_id;
			end else begin
				insert into #account 
				(
					account_id
				)
				select account.account_id
				from account_hierarchy_map
				join account 
					on account_hierarchy_map.child_id = account.account_id
				where account_hierarchy_map.parent_id = @account_id
					and account.account_level_code <> 3
					and account.deleted = 0
					and account.ad_hoc_flag = 0;
				select @sacct_id = account.short_name 
				from account 
				where account.account_id = @account_id;
			end;
		end else begin
			insert into #account 
			(
				account_id
			)
			select 
				account.account_id
			from workgroup_tree_map
			join account 
				on workgroup_tree_map.child_id = account.account_id
				and account.account_level_code <> 3
				and account.deleted = 0
				and account.ad_hoc_flag = 0			
			where workgroup_tree_map.parent_id = @account_id
				and workgroup_tree_map.child_type in (2, 3);
			select @sacct_id = workgroup.name 
			from workgroup 
			where workgroup_id = @account_id;
		end;
    end else begin
		select @current_user = @user_id;
		insert into #account
		(
			account_id
		)
		select
			account.account_id
		from user_access_map
		join account
			on user_access_map.object_id = account.account_id
			and account.deleted = 0
		where user_access_map.user_id = @current_user
			and user_access_map.object_type in (2, 3);
		select @sacct_id = 'All';
	end;		
select	@exchange_rate = exchange_rate, 
		@currency_name = mnemonic 
		from currency
		where security_id= @currency_id;
insert into #account_mkt_value 
		select	#account.account_id		as account_id,
				sum(((coalesce(positions.quantity,0)  
					* position_type.security_sign 
					* price.latest 
					* security.pricing_factor 
					* security.principal_factor) 
					/ principal.exchange_rate )
				+ ((coalesce(positions.accrued_income , 0) 
					* position_type.security_sign )
					/ income.exchange_rate))		as account_market_value
		from	positions
			join security			on positions.security_id = security.security_id
			join currency principal on security.principal_currency_id = principal.security_id
			join currency income	on security.income_currency_id	= income.security_id
			join price				on security.security_id = price.security_id
			join position_type		on positions.position_type_code = position_type.position_type_code
			join #account			on #account.account_id = positions.account_id
		group by #account.account_id
		having	sum(((coalesce(positions.quantity,0)  
					* position_type.security_sign 
					* price.latest 
					* security.pricing_factor 
					* security.principal_factor) 
					/ principal.exchange_rate )
				+ ((coalesce(positions.accrued_income , 0) 
					* position_type.security_sign )
					/ income.exchange_rate)) > 0;
insert	into #principal_exchange_rates
	(
	security_id,
	principal_cur_id,
	principal_exchange_rate
		)
	select	distinct security.security_id,
			security.principal_currency_id,
			currency.exchange_rate 
	from currency
		join	security	on security.principal_currency_id = currency.security_id
		join	positions	on  positions.security_id = security.security_id
		join	#account_mkt_value		on #account_mkt_value.account_id = positions.account_id ;
insert into #cash_balance
		select	distinct #account_mkt_value.account_id	as account_id,
				positions.position_id			as position_id,
				(case when positions.position_type_code in (1) 
					and security.major_asset_code = 0
						then positions.quantity 
				 else 0 
				 end * security.principal_factor 
					 * security.pricing_factor 
					 * price.latest) / #principal_exchange_rates.principal_exchange_rate
					 							as negative_cash,
				(case when positions.position_type_code in (0) 
					and security.major_asset_code = 0
						then positions.quantity 
				 else 0 
				 end * security.principal_factor 
					 * security.pricing_factor 
					 * price.latest)
					 / #principal_exchange_rates.principal_exchange_rate						
												as positive_cash,
				((case when positions.position_type_code in (0) 
					and security.major_asset_code = 0
						then 1
				 when positions.position_type_code in (1) 
					and security.major_asset_code = 0
						then -1
				 else 0
				 end * positions.quantity 
					 * security.principal_factor 
					 * security.pricing_factor 
					 * price.latest)
					 / #principal_exchange_rates.principal_exchange_rate)
												as total_cash
		from #account_mkt_value
			join positions					on #account_mkt_value.account_id = positions.account_id
			join security					on positions.security_id = security.security_id
			join price						on security.security_id = price.security_id
			join account					on #account_mkt_value.account_id = account.account_id
			join currency principal			on security.principal_currency_id = principal.security_id
			join currency income			on security.income_currency_id	= income.security_id
			join #principal_exchange_rates	on #principal_exchange_rates.security_id = security.security_id
			join position_type				on position_type.position_type_code = positions.position_type_code
		where ((case when positions.position_type_code in (1) 
					and security.major_asset_code = 0
						then positions.quantity 
				 else 0 
				 end * security.principal_factor 
					 * security.pricing_factor 
					 * price.latest) / #principal_exchange_rates.principal_exchange_rate ) > 0
			or ((case when positions.position_type_code in (0) 
					and security.major_asset_code = 0
						then positions.quantity 
				 else 0 
				 end * security.principal_factor 
					 * security.pricing_factor 
					 * price.latest)
					 / #principal_exchange_rates.principal_exchange_rate ) > 0 ;
	if exists(	select 1
		from #cash_balance
	) begin
		select	
			account.short_name														as short_name,
			account.name_1															as account_name,
			@currency_name															as currency,
			#cash_balance.account_id												as account_id,
			round(SUM(#cash_balance.positive_cash),12)								as positive_cash,
			round(SUM(#cash_balance.negative_cash),12)								as negative_cash,
			case 	when ((@include_positives > 0) and (@include_negatives > 0))  then round(SUM(#cash_balance.total_cash)* @exchange_rate,12)	
					when ((@include_positives > 0) and (@include_negatives <= 0)) then round(SUM(#cash_balance.positive_cash)* @exchange_rate,12)
					else	round(SUM(#cash_balance.negative_cash)* @exchange_rate  * (-1),12)
			end																		as total_cash,
			case 	when ((@include_positives > 0) and (@include_negatives > 0))  then round(sum(#cash_balance.total_cash) / #account_mkt_value.account_market_value,12)
					when ((@include_positives > 0) and (@include_negatives <= 0)) then round(sum(#cash_balance.positive_cash) / #account_mkt_value.account_market_value,12)
					else round((sum(#cash_balance.negative_cash) / #account_mkt_value.account_market_value) * (-1) ,12)
			end																		as pct_total_market_total,
			round(#account_mkt_value.account_market_value * @exchange_rate,12)		as market_val,
			
			case    when @account_id = -1 then 'All'
						else @account_name
						end															as acct_name,
			case    when @include_positives > 0 then 'Yes'
						else 'No'
						end															as include_positives,
			case    when @include_negatives > 0 then 'Yes'
						else 'No'
						end															as include_negatives
		from #cash_balance
			join account			on account.account_id = #cash_balance.account_id
			join #account_mkt_value on #account_mkt_value.account_id = #cash_balance.account_id
		group by	#cash_balance.account_id,
					#account_mkt_value.account_market_value,
					account.short_name,
					account.name_1
					
		having ( SUM(#cash_balance.positive_cash) > 0 and @include_positives > 0)
				or ( SUM(#cash_balance.negative_cash) > 0 and @include_negatives > 0);
		end else begin
		select 
			account.account_id							as account_id, 
			account.short_name							as short_name,
			account.name_1								as account_name,
			@currency_name								as currency,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			0											as neg_cash,
			0											as pos_cash,
			0											as total_cash,
			0											as pct_total_market_total,
			round(#account_mkt_value.account_market_value * @exchange_rate,12)		as market_val,
			case    when @account_id = -1 then 'All'
						else @account_name
						end								as acct_name,
			case    when @include_positives > 0 then 'Yes'
						else 'No'
						end								as include_positives,
			case    when @include_negatives > 0 then 'Yes'
						else 'No'
						end								as include_negatives
			from account
				join #account_mkt_value on #account_mkt_value.account_id = account.account_id;
	end;
	select @cpe_rpx_cmpl_pre_top_act_det = sysobjects.name
from sysobjects
where
	sysobjects.name = 'cpe_rpx_cmpl_pre_top_act_det'
	and sysobjects.type = 'P'
if @cpe_rpx_cmpl_pre_top_act_det is not null
begin
	execute @ret_val = cpe_rpx_cmpl_pre_top_act_det
		@account_id,
		@is_account_id,
		@include_negatives,
		@include_positives,
		@user_id,
		@currency_id
	if (@ret_val != 0 and @ret_val < 60000)
	begin
		return @ret_val
	end
end
end

go
if @@error = 0 print 'PROCEDURE: rpx_cash_balance created'
else print 'PROCEDURE: rpx_cash_balance error on creation'
go
