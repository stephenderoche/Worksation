USE [NAV_753]
GO
/****** Object:  StoredProcedure [dbo].[se_get_generic_view]    Script Date: 11/20/2018 10:49:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[se_get_generic_view]--se_get_generic_view 199,-1,-1,null,null,null,'Top Securities',172
(    
 @account_id			 numeric(10) = null, 
 @desk_id                numeric(10) = null,
 @security_id			 numeric(10) = null,
 @startdate	             datetime = null,
 @enddate		         datetime = null,
 @block_id               numeric(10) = null,
 @report                 Varchar(40) = null,
 @user_id                numeric(10)

 )    
as 


begin	




If (@report = 'Cash Balance')
    begin
	execute rpx_cash_balance @account_id,1,1,1,@user_id,1
	end 


If (@report = 'Account Compare')
    begin
	execute rpx_account_compare @account_id
	end 

If (@report = 'Security History')
    begin
	
      exec se_get_tradervspm_orders  @desk_id,@account_id,@security_id,-1,@startdate,@enddate,-1

	end
	
If (@report = 'Top Issuers')
    begin
	execute se_get_top_issuers_dasboard @account_id,20
	end 

If (@report = 'Top Securities')
    begin
	execute se_get_top_securities_dasboard @account_id,20
	end 

	If (@report = 'Wash Sales')
    begin
	exec se_get_wash_sale_viewer @account_id
	end 

	If (@report = 'Compliance Rules')
    begin
	exec rpx_cmpl_breach_sum @account_id,1,1,1,@startdate,@enddate
	end 



	If (@report = 'Restricted Securities')
    begin
	execute se_get_restricted_securities @account_id
	end 

	If (@report = 'Account Header')
    begin
	execute se_get_account_info_dashboard @account_id
	end 

	If (@report = 'Account Header')
    begin
	execute se_get_account_info_dashboard @account_id
	end 

	If (@report = 'Upcoming Corporate Actions')
    begin
	execute se_get_corporate_actions
	end 

	If (@report = 'Security Xref')
    begin
	execute se_get_positions_xref @account_id,@security_id
	end 

		If (@report = 'Missing Data')
    begin
	execute se_cmpl_get_missing_data @account_id,1
	end 


		If (@report = 'Nav Rule Matrix')
    begin
	

	execute ng_rpt_results_matrix_rule @account_id,1, @user_id, @startdate, @enddate 
	end 

		If (@report = 'Nav Results by Rule')
    begin
	

	execute ng_rpt_results_by_rule  @account_id,1, @user_id,@startdate, @startdate , -1, 0, -1, -1                 
               

	end 

		If (@report = 'Nav Results Matrix')
    begin
	


	exec ng_rpt_results_matrix_data  @account_id,1, @user_id,@startdate, @startdate , -1                
               

	end 

		If (@report = 'Nav Balances')
    begin
	


	execute get_nav_account_non_security @account_id, @startdate, 4.00000000             
               

	end 

		If (@report = 'AsOf Portfolio')
    begin
	
 
	execute get_asof_portfolio @account_id, 4.00000000, @startdate, 1          
               

	end 


	 


end

