CREATE VIEW [Inventory].[gmInventoryStatus]
AS

/*===============================================================================================================
[Inventory].[gmInventoryStatus]
***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.

Updated By:	Darin Witten
Updated On:	04/08/2023
Release:	2.0.0
Comments:	Adding logic for "Data Last Captured" and "Data Last Processed".

===============================================================================================================*/  

SELECT		 istat.[InventoryStatusPrimaryKey] AS [Inventory Status Primary Key]
			,istat.[InventStatusID] AS [Invent Status ID]
			,istat.[InventoryStatus] AS [Inventory Status]
			,istat.[InventorySubStatus] AS [Inventory SubStatus]
			,istat.[InventoryStatusCompanyKey] AS [Inventory Status Company Key]
			,istat.[InventoryStatusSourceSystemKey] AS [Inventory Status Source System Key]
			,b.[ETLBatchSeriesCreateDate] AS [Data Last Captured]
			,GETDATE() AS [Data Last Processed]

FROM		[Inventory].[gsInventoryStatus] AS istat

			LEFT JOIN 
						(
						SELECT		ETLBatchSeriesID
									,MAX(ETLBatchSeriesCreateDate) AS ETLBatchSeriesCreateDate
						FROM		Config.gsEtlBatchSeries
						GROUP BY	ETLBatchSeriesID
						) AS b ON istat.ETLBatchSeriesID = b.ETLBatchSeriesID

GO

