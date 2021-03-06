if exists (select * from sysobjects where name = 'se_get_hierarchy_sector_benchmark_totals')
begin
	drop procedure se_get_hierarchy_sector_benchmark_totals
	print 'PROCEDURE: se_get_hierarchy_sector_benchmark_totals dropped'
end
go


/*

declare @analytic float
  exec se_get_hierarchy_sector_benchmark_totals 
						  @analytic = @analytic output,
						  @account_id = 103,
						  @Hierarchy_sector_id = 12983,
						  @analytic_value = 1
print @analytic

*/

alter  procedure [dbo].[se_get_hierarchy_sector_benchmark_totals]
(    
      @analytic float output, 
      @account_id    numeric(10) = null,
      @Hierarchy_sector_id numeric(10),
      @analytic_value numeric(10)
    
)   
as  
 declare  @model_id       numeric(10);
 declare  @open_model_id  numeric(10);
 declare  @model_type      tinyint=0;   
 declare  @name        nvarchar(40) = null; 
 declare  @rounding_type      tinyint = 0;  
 declare  @rounding_quantity     float = 100;  
 declare  @minimum_type      tinyint = 0;  
 declare  @minimum_quantity     float = 100;  
 declare  @sell_non_model_holdings   tinyint = 0;  
 declare  @clear_proposed     tinyint = 0;  
 declare  @note        nvarchar(255) = null;  
 declare  @instruction_code     tinyint = 0;  
 declare  @positive_cash_flag    tinyint = 0;  
 declare  @number_cash_loops     int = 100;  
 declare  @market_movement_coefficient  int = 0;  
 declare  @restlist_processing   tinyint = 0;  
 declare  @restlist_error_level   tinyint = null; 
 declare  @exclude_encumbered_flag  tinyint = 0; 
 declare  @include_accrued_interest_flag tinyint = 0;  
 declare  @benchmark_model_id    numeric(10) = null;  
 declare  @target_type_code     int = 0 ;
 declare  @total_mv  numeric(10) = 0; 
 declare  @account_minimum_quantity float = null;
 declare  @account_maximum_quantity float = null;
 declare  @account_short_name nvarchar(100) = null;
 
 declare @analytic_benchmark_id numeric(10) = null;
 declare @hierarchy_id   numeric(10) = null;
 declare @current_user          numeric(10) = 198
 declare @major_asset_code smallint = 3;
begin  
 set nocount on  


 select @analytic_benchmark_id = (select default_analytic_benchmark_id from account where account_id = @account_id)
 select @hierarchy_id = coalesce((select default_hierarchy_id from account where account_id = @account_id),9)
 
  create table #tmpResults ( account_id numeric(10) null,
                            short_name nvarchar(100) null,
                            account_minimum_quantity float null,
                            account_maximum_quantity float null,
                            hierarchy_sector_id numeric(10),
							security_level_code tinyint,
							master_security_id numeric(10),
							depth smallint,
							parent_sector_id numeric(10),
                            modified_duration float,
                            yield_to_maturity float,
                            current_WAM float,
                            macaulay_duration float,
                            --[rank] int,
                            --quality_rating varchar(10) null,
                            --rating_service_code int null,
                            --name varchar(20) null,
                            total_market_value numeric(10),
                            simple_yield float,
                            current_yield float,
                            alpha float,
                            gamma float,
                            delta float,
                            [target] float,
                            convexity float,
                            effective_convexity float,
                            effective_WAM float,
                            effective_macaulay_duration float,
                            effective_modified_duration float,
                            effective_yield float,
                            weighted_average_life float)                          
 
 select @model_id = default_model_id,
        @hierarchy_id = default_hierarchy_id,
        @analytic_benchmark_id = default_analytic_benchmark_id,
        @account_minimum_quantity = minimum_quantity,
        @account_maximum_quantity = isnull(user_field_5,0), -- using user_field_5 for account maximum_quantity
        @account_short_name = short_name 
  from account
 where account_id = @account_id;
 
 select @model_id = -1
 
 -- get account total market value
 exec psg_get_account_market_value_bbh @total_mv output,@account_id,1.0 
 
 
  if(@model_id <= 0)
    begin
   exec se_create_model @model_id output,
				 @model_type,--0
				 @hierarchy_id,
				 @current_user,
				 @name,
				 @account_id,
				 @rounding_type,--0
				 @rounding_quantity,--100
				 @minimum_type,--0
				 @minimum_quantity,--100
				 @sell_non_model_holdings,--0
				 @clear_proposed,--0
				 @note,
				 @instruction_code,--0
				 @positive_cash_flag,--0
				 @number_cash_loops,--100
				 @market_movement_coefficient,--0
				 @restlist_processing,--0
				 @restlist_error_level,
				 @current_user, 
				 @exclude_encumbered_flag,--0
				 @include_accrued_interest_flag,--0
				 @benchmark_model_id,
				 @target_type_code --0
    end;

INSERT INTO #tmpResults 
  select 
    @account_id,
    @account_short_name,
    @account_minimum_quantity,
    @account_maximum_quantity,
    hierarchy_sector_map.hierarchy_sector_id, 
    all_securities.security_level_code,  
    all_securities.master_security_id,  
    hierarchy_sector.depth,  
    hierarchy_sector.parent_sector_id,
    SUM(security_analytics.modified_duration * model_security.target) / SUM(model_security.target) as modified_duration,
    SUM(security_analytics.yield_to_maturity * model_security.target) / SUM(model_security.target) as yield_to_maturity,
    SUM(security_analytics.current_WAM * model_security.target) / SUM(model_security.target) as current_WAM, 
    SUM(security_analytics.macaulay_duration * model_security.target) / SUM(model_security.target) as macaulay_duration,
    --AVG(quality_rating_rank.rank) as [rank],
    --null as quality_rating,
    --quality_rating_rank.rating_service_code,
    --rating_service.name, 
    @total_mv as total_market_value,         
    SUM(security_analytics.simple_yield * model_security.target) / SUM(model_security.target) as simple_yield,
    SUM(security_analytics.current_yield * model_security.target) / SUM(model_security.target) as current_yield,
    SUM(security_analytics.alpha * model_security.target) / SUM(model_security.target) as alpha,
    SUM(security_analytics.gamma * model_security.target) / SUM(model_security.target) as gamma,
    SUM(security_analytics.delta * model_security.target) / SUM(model_security.target) as delta,
    SUM(model_security.target) as [target],
    SUM(security_analytics.convexity * model_security.target) / SUM(model_security.target) as convexity,
    SUM(security_analytics.effective_convexity * model_security.target) / SUM(model_security.target) as effective_convexity,
    SUM(security_analytics.effective_WAM * model_security.target) / SUM(model_security.target) as effective_WAM,
    SUM(security_analytics.effective_macaulay_duration * model_security.target) / SUM(model_security.target) as effective_macaulay_duration,
    SUM(security_analytics.effective_modified_duration * model_security.target) / SUM(model_security.target) as effective_modified_duration,
    SUM(security_analytics.effective_yield * model_security.target) / SUM(model_security.target) as effective_yield,
    SUM(security_analytics.weighted_average_life * model_security.target) / SUM(model_security.target) as weighted_average_life
  from  
(  
     select security.security_id,  
       security.major_asset_code,  
       security.sic_code,  
       security.country_code,  
       security.created_time,  
       security.principal_currency_id,  
       security.security_level_code,  
       security.name_1,  
       security.symbol,  
       security.master_security_id,
       security.deleted
     from security  
     union   
     select security_master.security_master_id as security_id,  
       security_master.major_asset_code,  
       security_master.sic_code,  
       security_master.country_code,  
       security_master.created_time,  
       security_master.principal_currency_id,  
       security_master.security_level_code,  
       security_master.name_1,  
       security_master.symbol,  
       null as master_security_id,  
       security_master.deleted
     from security_master  
    ) all_securities    
    inner join model_security  
		on model_security.security_id = all_securities.security_id and all_securities.deleted = 0
    inner join price 
		on model_security.security_id = price.security_id     
    inner join hierarchy_sector_map   
		on hierarchy_sector_map.security_id = all_securities.security_id and  hierarchy_sector_map.hierarchy_id = @hierarchy_id   
	inner join   hierarchy_sector  
		on hierarchy_sector_map.hierarchy_sector_id = hierarchy_sector.hierarchy_sector_id
  inner join security_analytics 
		on  all_securities.security_id = security_analytics.security_id
  --LEFT OUTER JOIN quality_rating 
		--on quality_rating.security_id = all_securities.security_id
  --inner join quality_rating_rank 
		--on quality_rating_rank.quality_rating_code = quality_rating.quality_rating_code  
  --INNER JOIN rating_service 
  --      on rating_service.rating_service_code = quality_rating_rank.rating_service_code       
  where  
  all_securities.major_asset_code = @major_asset_code
  and 
  all_securities.security_level_code in (0, 1) 
  and  model_security.model_id = @model_id   
  and  (  
     @account_id is not null  
     and all_securities.security_id in  
     ( select security_id   
      from positions  
      join account_hierarchy_map  
      on  positions.account_id = account_hierarchy_map.child_id  
      where account_hierarchy_map.parent_id = @account_id 
     )  
    or @account_id is null  
   )  
    group by 
     hierarchy_sector_map.hierarchy_sector_id,  
    all_securities.security_level_code,  
    all_securities.master_security_id,  
    hierarchy_sector.depth,  
    hierarchy_sector.parent_sector_id
    --quality_rating_rank.rating_service_code,
    --rating_service.name
  order by hierarchy_sector_map.hierarchy_sector_id;  
 end 

--update #tmpResults set #tmpResults.quality_rating = r.quality_rating
--from  #tmpResults
-- inner join quality_rating_rank r
--		on r.rating_service_code = #tmpResults.rating_service_code and r.rank = #tmpResults.rank 


--1	8	modified_duration
--2	9	effective_modified_duration
--3	10	yield_to_maturity
--4	11	effective_yield
--5	12	macaulay_duration
--6	13	effective_macaulay_duration
--7	14	convexity
--8	15	effective_convexity
--9	16	current_WAM
--10	17	effective_WAM
--11	18	issuer_name
			
 if @analytic_value=1
   begin
    select	@analytic =
        Round(Coalesce(modified_duration,0),4)
       
        from #tmpResults
    where #tmpResults.hierarchy_sector_id = @Hierarchy_sector_id
  end  
  
   if @analytic_value=2
   begin
    select	@analytic =	
        Round(Coalesce(effective_modified_duration,0),2)
        from #tmpResults
    where #tmpResults.hierarchy_sector_id = @Hierarchy_sector_id
  end  
  
    if @analytic_value=3
   begin
    select	@analytic =
        Round(Coalesce(yield_to_maturity,0),2)
        from #tmpResults
    where #tmpResults.hierarchy_sector_id = @Hierarchy_sector_id
  end       
        
        
      if @analytic_value=4
   begin
    select	@analytic =
       Round( Coalesce(effective_yield,0),2)
        from #tmpResults
    where #tmpResults.hierarchy_sector_id = @Hierarchy_sector_id
  end      
  
        if @analytic_value=5
   begin
    select	@analytic =	
      Round( Coalesce( macaulay_duration,0),2)
        from #tmpResults
    where #tmpResults.hierarchy_sector_id = @Hierarchy_sector_id
  end   
  
        if @analytic_value=6
   begin
    select	@analytic =	
       Round( Coalesce(effective_macaulay_duration,0),2)
        from #tmpResults
    where #tmpResults.hierarchy_sector_id = @Hierarchy_sector_id
  end   
  
     if @analytic_value=7
   begin
    select	@analytic =
       Round( Coalesce(convexity,0),2)
        from #tmpResults
    where #tmpResults.hierarchy_sector_id = @Hierarchy_sector_id
  end   
  
       if @analytic_value=8
   begin
    select	@analytic =
       Round( Coalesce(effective_convexity,0) ,2)
        from #tmpResults
    where #tmpResults.hierarchy_sector_id = @Hierarchy_sector_id
  end 
  
         if @analytic_value=9
   begin
    select	@analytic =
       Round( Coalesce(current_WAM,0),2)
        from #tmpResults
    where #tmpResults.hierarchy_sector_id = @Hierarchy_sector_id
  end   
        
   if @analytic_value=10
   begin
    select	@analytic =
      Round(  Coalesce(effective_WAM,0) ,2)
        from #tmpResults
    where #tmpResults.hierarchy_sector_id = @Hierarchy_sector_id
  end   
  
   if @analytic_value=11
   begin
    select	@analytic =
      Round(  Coalesce(beta,0) ,2)
        from #tmpResults
    where #tmpResults.hierarchy_sector_id = @Hierarchy_sector_id
  end  	

go
if @@error = 0 print 'PROCEDURE: se_get_hierarchy_sector_benchmark_totals created'
else print 'PROCEDURE: se_get_hierarchy_sector_benchmark_totals error on creation'
go

    
   
    
    
    

