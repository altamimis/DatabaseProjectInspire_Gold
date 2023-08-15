CREATE VIEW [Company].[gmFinancialDim] 
AS 

/*===============================================================================================================
[Company].[gmFinancialDim]
***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.

Updated By:	Darin Witten
Updated On:	04/08/2023
Release:	2.0.0
Comments:	Adding logic for "Data Last Captured" and "Data Last Processed".

===============================================================================================================*/  

SELECT DISTINCT	fd.DimAttributeValueSetID AS [Financial Dim Primary Key]
				,COALESCE(cc.FinancialDimValue, '') AS [Cost Center]
				,COALESCE(cc.FinancialDimValueDesc, '') AS [Cost Center Desc]
				,COALESCE(dp.FinancialDimValue, '') AS [Department]
				,COALESCE(dp.FinancialDimValueDesc, '') AS [Department Desc]
				,COALESCE(ev.FinancialDimValue, '') AS [Events]
				,COALESCE(ev.FinancialDimValueDesc, '') AS [Events Desc]
				,COALESCE(fc.FinancialDimValue, '') AS [Freight Carrier]
				,COALESCE(fc.FinancialDimValueDesc, '') AS [Freight Carrier Desc]
				,COALESCE(mc.FinancialDimValue, '') AS [Marketing Co-Op]
				,COALESCE(mc.FinancialDimValueDesc, '') AS [Marketing Co-Op Desc]
				,COALESCE(p.FinancialDimValue, '') AS [Product]
				,COALESCE(p.FinancialDimValueDesc, '') AS [Product Desc]
				,COALESCE(pd.FinancialDimValue, '') AS [Product Development]
				,COALESCE(pd.FinancialDimValueDesc, '') AS [Product Development Desc]
				,b.[ETLBatchSeriesCreateDate] AS [Data Last Captured]
				,GETDATE() AS [Data Last Processed]
	
FROM			[Company].[gsFinancialDim] AS fd
			
				/*CostCenter*/
				LEFT JOIN [Company].[gsFinancialDim] AS cc
															ON fd.DimAttributeValueSetID = cc.DimAttributeValueSetID
															AND cc.FinancialDim = 'CostCenter'
			
				/*Department*/
				LEFT JOIN [Company].[gsFinancialDim] AS dp
															ON fd.DimAttributeValueSetID = dp.DimAttributeValueSetID
															AND dp.FinancialDim = 'Department'
			
				/*Events*/
				LEFT JOIN [Company].[gsFinancialDim] AS ev
															ON fd.DimAttributeValueSetID = ev.DimAttributeValueSetID
															AND ev.FinancialDim = 'Events'
			
				/*FreightCarrier*/
				LEFT JOIN [Company].[gsFinancialDim] AS fc
															ON fd.DimAttributeValueSetID = fc.DimAttributeValueSetID
															AND fc.FinancialDim = 'FreightCarrier'
			
				/*MarketingCo_Op*/
				LEFT JOIN [Company].[gsFinancialDim] AS mc
															ON fd.DimAttributeValueSetID = mc.DimAttributeValueSetID
															AND mc.FinancialDim = 'MarketingCo_Op'

				/*Product*/
				LEFT JOIN [Company].[gsFinancialDim] AS p
															ON fd.DimAttributeValueSetID = p.DimAttributeValueSetID
															AND p.FinancialDim = 'Product'
			
				/*ProductDevelopment*/
				LEFT JOIN [Company].[gsFinancialDim] AS pd
															ON fd.DimAttributeValueSetID = pd.DimAttributeValueSetID
															AND pd.FinancialDim = 'ProductDevelopment'

				LEFT JOIN 
							(
							SELECT		ETLBatchSeriesID
										,MAX(ETLBatchSeriesCreateDate) AS ETLBatchSeriesCreateDate
							FROM		Config.gsEtlBatchSeries
							GROUP BY	ETLBatchSeriesID
							) AS b ON fd.ETLBatchSeriesID = b.ETLBatchSeriesID

GO

