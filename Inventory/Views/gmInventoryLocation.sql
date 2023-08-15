CREATE VIEW [Inventory].[gmInventoryLocation] 
AS 

/*===============================================================================================================
[Inventory].[gmInventoryLocation] 
***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.

Updated By:	Darin Witten
Updated On:	04/08/2023
Release:	2.0.0
Comments:	Adding logic for "Data Last Captured" and "Data Last Processed".

===============================================================================================================*/   

SELECT	 il.[InventoryLocationPrimaryKey] AS [Inventory Location Primary Key]
		,il.[SiteID] AS [Site ID]
		,il.[SiteName] AS [Site Name]
		,il.[WarehouseID] AS [Warehouse ID]
		,il.[WarehouseName] AS [Warehouse Name]
		,il.[LocationID] AS [Location ID]
		,il.[LocationName] AS [Location Name]
		,il.[InventoryLocationCompanyKey] AS [Inventory Location Company Key]
		,il.[InventoryLocationSourceSystemKey] AS [Inventory Location Source System Key]
		,b.[ETLBatchSeriesCreateDate] AS [Data Last Captured]
		,GETDATE() AS [Data Last Processed]

FROM	[Inventory].[gsInventoryLocation] AS il

		LEFT JOIN 
				(
				SELECT		ETLBatchSeriesID
							,MAX(ETLBatchSeriesCreateDate) AS ETLBatchSeriesCreateDate
				FROM		Config.gsEtlBatchSeries
				GROUP BY	ETLBatchSeriesID
				) AS b ON il.ETLBatchSeriesID = b.ETLBatchSeriesID

GO

