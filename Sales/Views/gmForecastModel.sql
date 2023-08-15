CREATE VIEW [Sales].[gmForecastModel] 
AS 

/*===============================================================================================================
[Sales].[gmForecastModel] 
***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.

Updated By:	Darin Witten
Updated On:	04/08/2023
Release:	2.0.0
Comments:	Adding logic for "Data Last Captured" and "Data Last Processed".

===============================================================================================================*/ 

SELECT	 fm.[SalesForecastModelPrimaryKey] AS [Sales Forecast Model Primary Key] 
		,fm.[SalesForecastModelID] AS [Sales Forecast Model ID] 
		,fm.[SalesForecastModelName] AS [Sales Forecast Model Name] 
		,fm.[SalesForecastModelCompanyKey] AS [Sales Forecast Model Company Key] 
		,fm.[SalesForecastSourceSystemKey] AS [Sales Forecast Source System Key]
		,b.[ETLBatchSeriesCreateDate] AS [Data Last Captured]
		,GETDATE() AS [Data Last Processed]

FROM	[Sales].[gsForecastModel] AS fm

		LEFT JOIN 
						(
						SELECT		ETLBatchSeriesID
									,MAX(ETLBatchSeriesCreateDate) AS ETLBatchSeriesCreateDate
						FROM		Config.gsEtlBatchSeries
						GROUP BY	ETLBatchSeriesID
						) AS b ON fm.ETLBatchSeriesID = b.ETLBatchSeriesID

WHERE	fm.[SalesForecastModelPrimaryKey] IS NOT NULL

GO

