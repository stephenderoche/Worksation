if exists (select * from sysobjects where name = 'se_fi_asset_allocation_pru_by_accout_id')
begin
	drop procedure se_fi_asset_allocation_pru_by_accout_id
	print 'PROCEDURE: se_fi_asset_allocation_pru_by_accout_id dropped'
end
go
create procedure [dbo].[se_fi_asset_allocation_pru_by_accout_id] --se_fi_asset_allocation_pru_by_accout_id 199,'Major asset'
(	
	@account_id			numeric(10),
    @hierarchy_name     nvarchar(40) = 'Fixed Income',
    @isAccountId		smallint = 1,			/* this parameter is ignored, this report will only run on accounts */
    @userid				numeric(10)= 198,
	@include_proposed	bit = 1
)

as

	declare @ret_val				int;

	declare @account_name			nvarchar(40);

	declare @account_short_name		nvarchar(40);

	declare @model_name				nvarchar(40); 

    declare @benchmark_model_name	nvarchar(40); 

    declare @total_asset			float;      

    declare @total_asset_cost		float;    

    declare @total_income			float;  

    declare @hierarchy_id			numeric(10);

    declare @sector_id				numeric(10);

    declare @sector_mv				float;

    declare @account_market_value	numeric(10);

	



   

     declare @run_date				datetime;

begin





                    set nocount on;

                      declare @ec__errno int;

                     declare @sp_initial_trancount int;

                     declare @sp_trancount int;









	-- create temple to hold the IDs of the requested accounts

	create table #account  	(  		account_id numeric(10) not null  	);

	select @run_date = getdate();

	select 

		@account_short_name		= short_name,

		

		@model_name				= user_field_11,

		@benchmark_model_name	= user_field_12

	

	from account

	where account_id = @account_id;







	select 

		@hierarchy_id = hierarchy_id

	from hierarchy

	where name = @hierarchy_name;







	/* populate #account with reqeuested accounts */



	execute rpx_populate_t_account  

							@account_id		= @account_id,	

							@is_account_id	= 1, 

							@user_id		= @userid, 

							@account_name	= @account_name output; 



	



		execute get_account_market_value 



								@market_value		= @account_market_value output, 

								@account_id			= @account_id, 

								@market_value_type	= 4, 

								@currency_id		= 183

		select 
		  

	       top(10)
			case

				when hierarchy_sector.description is not null then hierarchy_sector.description



				else 'Unknown'



				end as Symbol,
				@account_market_value as MV,
			round(detail.PctTotal, 4)  as PctTotal



		from 

		(

			select  

				case



					when hierarchy_sector.parent_sector_id is null then hierarchy_sector.hierarchy_sector_id



					when parent1.parent_sector_id is null then parent1.hierarchy_sector_id



                    when parent2.parent_sector_id is null then parent2.hierarchy_sector_id



					when parent3.parent_sector_id is null then parent3.hierarchy_sector_id



					when parent4.parent_sector_id is null then parent4.hierarchy_sector_id



					when parent5.parent_sector_id is null then parent5.hierarchy_sector_id



					when parent6.parent_sector_id is null then parent6.hierarchy_sector_id



					else null 

					end as hierarchy_sector_id,



				sum(holdings.accrued_income) as accrued_income,



				round(sum(holdings.accrued_income) /

					sum(



						(holdings.quantity



							* price.latest

							* security.pricing_factor



							* security.principal_factor



							/ case when currency.exchange_rate is null then 1



								when currency.exchange_rate = 0 then 1



								else currency.exchange_rate



								end





					)

						+ 



						(holdings.accrued_income



							/ case when income_currency.exchange_rate is null then 1

								when income_currency.exchange_rate = 0 then 1

								else income_currency.exchange_rate

								end

						)



						* coalesce(holdings.security_sign, 1.0)  

						), 4) as yield,



				sum(



						(holdings.quantity 

						 * coalesce(holdings.unit_cost, 0)

						 * security.pricing_factor



						 * security.principal_factor









						 / case when currency.exchange_rate is null then 1



								when currency.exchange_rate = 0 then 1

								else currency.exchange_rate

								end

						)



					) as total_cost,



				sum(

						(holdings.quantity



						 * price.latest



						 * security.pricing_factor



						 * security.principal_factor



						 / case when currency.exchange_rate is null then 1



								when currency.exchange_rate = 0 then 1



								else currency.exchange_rate



								end

						)

						+ 

						(holdings.accrued_income



						 / case when income_currency.exchange_rate is null then 1



								when income_currency.exchange_rate = 0 then 1



								else income_currency.exchange_rate



								end

						)



						* coalesce(holdings.security_sign, 1.0)      

					) as mv_booked,



				sum(



						(holdings.quantity



						 * price.latest

                          * security.pricing_factor

							 * security.principal_factor

						 / case when currency.exchange_rate is null then 1

							when currency.exchange_rate = 0 then 1

							else currency.exchange_rate

							end



							)



						+ 

						(holdings.accrued_income



						 / case when income_currency.exchange_rate is null then 1



								when income_currency.exchange_rate = 0 then 1

								else income_currency.exchange_rate

								end

						)

						* coalesce(holdings.security_sign, 1.0)      

					) / @account_market_value as 'PctTotal'

					--rpx_fi_asset_allocation 17061,0,198,'default',0,'YTM'

			from
			(
				select 

					positions.security_id,

					positions.quantity,

					position_type.security_sign,

					positions.accrued_income,

					positions.unit_cost   

				from #account

               join positions

               on #account.account_id = positions.account_id

               join position_type 

             on positions.position_type_code = position_type.position_type_code

				union all

				select

					proposed_orders.security_id,

					proposed_orders.quantity,

					side.security_sign,

					0 as accrued_income,

					price.latest as unit_cost

				from #account

   			join proposed_orders

           on #account.account_id = proposed_orders.account_id

           join side

          on proposed_orders.side_code = side.side_code

		  join price

        on proposed_orders.security_id = price.security_id

          where @include_proposed = 1

		  union all

				select

					orders.security_id,

					orders.quantity,

					side.security_sign,

					0 as accrued_income,

					price.latest as unit_cost

				from #account

   			join orders

           on #account.account_id = orders.account_id

           join side

          on orders.side_code = side.side_code

		  join price

        on orders.security_id = price.security_id

          where @include_proposed = 1
		  and orders.deleted = 0

          ) holdings

       join security

     on holdings.security_id = security.security_id

			join price 

				on security.security_id  = price.security_id

			join currency 

				on security.principal_currency_id = currency.security_id

			join currency income_currency 

				on security.income_currency_id = income_currency.security_id

			left outer join hierarchy_sector_map

				on hierarchy_sector_map.hierarchy_id = @hierarchy_id

				and holdings.security_id = hierarchy_sector_map.security_id

			left outer join hierarchy_sector

				on hierarchy_sector_map.hierarchy_sector_id = hierarchy_sector.hierarchy_sector_id

			left outer join hierarchy_sector parent1

				on hierarchy_sector.parent_sector_id = parent1.hierarchy_sector_id

			left outer join hierarchy_sector parent2

				on parent1.parent_sector_id = parent2.hierarchy_sector_id

			left outer join hierarchy_sector parent3

				on parent2.parent_sector_id = parent3.hierarchy_sector_id

			left outer join hierarchy_sector parent4

				on parent3.parent_sector_id = parent4.hierarchy_sector_id

			left outer join hierarchy_sector parent5

				on parent4.parent_sector_id = parent5.hierarchy_sector_id

			left outer join hierarchy_sector parent6

				on parent5.parent_sector_id = parent6.hierarchy_sector_id

			left outer join security_analytics

				    on security_analytics.security_id = security.security_id

			group by case

						when hierarchy_sector.parent_sector_id is null then hierarchy_sector.hierarchy_sector_id

						when parent1.parent_sector_id is null then parent1.hierarchy_sector_id

						when parent2.parent_sector_id is null then parent2.hierarchy_sector_id

						when parent3.parent_sector_id is null then parent3.hierarchy_sector_id

						when parent4.parent_sector_id is null then parent4.hierarchy_sector_id

						when parent5.parent_sector_id is null then parent5.hierarchy_sector_id

						when parent6.parent_sector_id is null then parent6.hierarchy_sector_id

						else null

						end 



		) detail
		


		join account

			on account.account_id = @account_id

		left outer join hierarchy_sector

			on detail.hierarchy_sector_id = hierarchy_sector.hierarchy_sector_id

		order by coalesce(PctTotal, 9999999)desc;


    end

	go
if @@error = 0 print 'PROCEDURE: se_fi_asset_allocation_pru_by_accout_id created'
else print 'PROCEDURE: se_fi_asset_allocation_pru_by_accout_id error on creation'
go





