if exists (select * from sysobjects where name = 'se_get_analytic_benchmark')
begin
	drop procedure se_get_analytic_benchmark
	print 'PROCEDURE: se_get_analytic_benchmark dropped'
end
go

create procedure [dbo].[se_get_analytic_benchmark] --se_get_analytic_benchmark 103,3,189
(
	@account_id numeric(10),
	@analytic_type numeric(10),
	@current_user numeric(10)
	
	
) 
as
	declare @hierarchy_id numeric(10);
begin
                        set nocount on;
                        declare @ec__errno int;
                        declare @sp_initial_trancount int;
                        declare @sp_trancount int;
						declare @min_hierachy_id numeric(10)
						declare @holdings_weighed_average float
						declare @analytic float
						declare @analytic_benchmark_id numeric(10) = - 1
	                    declare @model_hierarchy_id numeric(10)

	select	
  @analytic_benchmark_id = default_analytic_benchmark_id
	from account
	where account_id = @account_id

	select	
		@model_hierarchy_id = hierarchy_id
	from analytic_benchmark
	where analytic_benchmark.analytic_benchmark_id = @analytic_benchmark_id;


	select	
		@hierarchy_id = hierarchy_id
	from analytic_benchmark
	where analytic_benchmark.analytic_benchmark_id = @analytic_benchmark_id;
	select *
	 into #temp
	    from
		(
	select distinct		
		analytic_benchmark.analytic_benchmark_id,
		security_master.security_master_id,
		coalesce(hierarchy_sector_map.hierarchy_sector_id,-1) as hierarchy_sector_id,
		security_master.symbol,
		security_analytics.current_yield,
		security_analytics.yield_to_maturity,
		security_analytics.macaulay_duration,
		security_analytics.modified_duration,
		security_analytics.convexity,
		security_analytics.current_WAM,
		security_analytics.effective_yield,
		security_analytics.effective_macaulay_duration,
		security_analytics.effective_modified_duration,
		security_analytics.effective_convexity,
		security_analytics.effective_WAM,
		security_analytics.option_adjusted_spread,
		security_analytics.benchmark_spread,
		security_analytics.weighted_average_life,
		analytic_benchmark.hierarchy_id,
		holdings_weighted_average = -1.0000,

		(
			select	quality_rating_rank.quality_rating
			from quality_rating
			join quality_rating_rank
				on quality_rating.quality_rating_code = quality_rating_rank.quality_rating_code
			join rating_definitions
				on quality_rating_rank.rating_service_code = rating_definitions.rating_service_code
			where quality_rating.security_id = security_master.security_master_id
				and	rating_definitions.sort_order = 1
				and	rating_definitions.major_asset_code = security_master.major_asset_code
				and	rating_definitions.debt_type_code = security_master.debt_type_code
		) as quality_rating_1
		
	from (
		select 
			user_analytic_benchmark.analytic_benchmark_id
		from user_access_map
		join user_analytic_benchmark
			on user_access_map.object_id = user_analytic_benchmark.user_id
		where user_access_map.user_id = @current_user
			and user_access_map.object_type = 0
		union
		select 
			user_analytic_benchmark.analytic_benchmark_id
		from user_analytic_benchmark
		where user_analytic_benchmark.user_id = @current_user
		) accessible_benchmarks
	join analytic_benchmark
		on accessible_benchmarks.analytic_benchmark_id = analytic_benchmark.analytic_benchmark_id
		and analytic_benchmark.analytic_benchmark_id = @analytic_benchmark_id
	join analytic_benchmark_value
		on analytic_benchmark.analytic_benchmark_id = analytic_benchmark_value.analytic_benchmark_id
	join security_master
		on analytic_benchmark_value.security_id = security_master.security_master_id
		and security_master.security_level_code = 3
	left join hierarchy_sector_map
		on security_master.security_master_id = hierarchy_sector_map.security_id
		and hierarchy_sector_map.hierarchy_id = @hierarchy_id
		and @hierarchy_id = @model_hierarchy_id
	left join security_analytics
		on security_master.security_master_id = security_analytics.security_id
	left join price
		on security_master.security_master_id = price.security_id
		)s

		  select @min_hierachy_id = min(hierarchy_sector_id) from #temp;

                     while (@min_hierachy_id is not null)
                     begin

					 if(@min_hierachy_id = -1)
					 begin

					   execute se_get_WAVG_analytics 
                       @analytic = @analytic output,
                       @account_id = @account_id,
                       @Hierarchy_sector_id = @min_hierachy_id,
                       @analytic_value = @analytic_type,
                       @portfolio = 1

					 update #temp
					 set #temp.symbol = 'Total'
					 where #temp.hierarchy_sector_id = @min_hierachy_id

					 end
					 else
					 begin
					  exec se_get_hierarchy_sector_benchmark_totals 
						  @analytic = @analytic output,
						  @account_id = @account_id,
						  @Hierarchy_sector_id =  @min_hierachy_id,
						  @analytic_value = @analytic_type

					 end

					 update #temp
					 set #temp.holdings_weighted_average = @analytic
					 where #temp.hierarchy_sector_id = @min_hierachy_id

					 select @analytic = 0
					  
					  
					  select @min_hierachy_id = min(hierarchy_sector_id) from #temp where hierarchy_sector_id > @min_hierachy_id;
                                        

                    end; 

					select * from #temp
	
end

go
if @@error = 0 print 'PROCEDURE: se_get_analytic_benchmark created'
else print 'PROCEDURE: se_get_analytic_benchmark error on creation'
go