CREATE VIEW [Sales].[gmSalesForecast] 
AS 

/*===============================================================================================================
[Sales].[gmSalesForecast] 

***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.

Updated By:	Darin Witten
Updated On:	04/08/2023
Version:	2.0.0
Comments:	Adding [Sales Forecast Date] to be used for relationship to Calendar table in Data Model.
			Adding logic for "Data Last Captured" and "Data Last Processed".

Updated By:	Jonathan Moelling
Updated On:	05/23/2023
Version:	2.0.0
Comments:	Removed [Sales Forecast Calendar Key] and added [Sales Forecast Date Key].

===============================================================================================================*/ 

SELECT	 sf.[SalesForecastPrimaryKey] AS [Sales Forecast Primary Key] 
		,sf.[SalesForecastModelKey] AS [Sales Forecast Model Key] 
		,sf.[SalesForecastCompanyKey] AS [Sales Forecast Company Key] 
		,sf.[SalesForecastCustomerKey] AS [Sales Forecast Customer Key] 
		,sf.[SalesForecastProductKey] AS [Sales Forecast Product Key] 
		,sf.[SalesForecastTotal] AS [Root - Sales Forecast Amount] 
		,sf.[SalesForecastQuantity] AS [Root - Sales Forecast Quantity] 
		,sf.[SalesForecastCostTotal] AS [Root - Sales Forecast Cost] 
		,sf.[SalesForecastCurrencyCode] AS [Sales Forecast Currency Code] 
		,sf.[SalesForecastSourceSystemKey] AS [Sales Forecast Source System Key] 
		,sf.[DefaultDimension] AS [Default Dimension] 
		,CAST(CONVERT(CHAR(8), sf.[SalesForecastDate], 112) AS INT) AS [Sales Forecast Date Key]
		,CAST(sf.SalesForecastDate AS DATETIME) AS [Sales Forecast Date]
		,CAST(b.[ETLBatchSeriesCreateDate] AS DATETIME) AS [Data Last Captured]
		,GETDATE() AS [Data Last Processed]

FROM	[Sales].[gsSalesForecast] AS sf

		LEFT JOIN 
						(
						SELECT		ETLBatchSeriesID
									,MAX(ETLBatchSeriesCreateDate) AS ETLBatchSeriesCreateDate
						FROM		Config.gsEtlBatchSeries
						GROUP BY	ETLBatchSeriesID
						) AS b ON sf.ETLBatchSeriesID = b.ETLBatchSeriesID

GO

