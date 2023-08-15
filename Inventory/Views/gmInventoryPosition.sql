CREATE VIEW [Inventory].[gmInventoryPosition] 
AS 

/*===============================================================================================================
[Inventory].[gmInventoryPosition] 
***Proprietary & Confidential*** 
Copyright© 2022, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.

Updated By:	Darin Witten
Updated On:	04/08/2023
Release:	2.0.0
Comments:	Adding logic for "Data Last Captured" and "Data Last Processed".
			Updated the "Inventory Position Capture Date" column to ShortDate format.

Updated By: Jonathan Moelling
Updated On: 05/23/2023
Comments:	Replaced [Inventory Position Capture Calendar Key] with [Inventory Position Capture Date Key].

===============================================================================================================*/  

SELECT	 ipos.[InventoryPositionProductKey] AS [Inventory Position Product Key] 
		,ipos.[InventoryPositionProductBatchKey] AS [Inventory Position Product Batch Key] 
		,ipos.[InventoryPositionInventoryLocationKey] AS [Inventory Position Inventory Location Key] 
		,ipos.[InventoryPositionCompanyKey] AS [Inventory Position Company Key] 
		,CAST(CONVERT(CHAR(8), ipos.[InventoryPositionCaptureDate], 112) AS INT) AS [Inventory Position Capture Date Key]
		,CAST(ipos.[InventoryPositionCaptureDate] AS DATE) AS [Inventory Position Capture Date] 
		,ipos.[InventoryOwnerName] AS [Inventory Owner Name] 
		,ipos.[InventoryPositionSourceSystemKey] AS [Inventory Position Source System Key] 
		,ipos.[InventoryStatusKey] AS [Inventory Status Key]
		,ipos.[PostedQuantity] AS [Root - Posted Quantity] 
		,ipos.[DeductedQuantity] AS [Root - Deducted Quantity] 
		,ipos.[ReceivedQuantity] AS [Root - Received Quantity] 
		,ipos.[PhysicalInventoryQuantity] AS [Root - Physical Inventory Quantity] 
		,ipos.[PhysicalReservedQuantity] AS [Root - Physical Reserved Quantity] 
		,ipos.[PhysicalAvailableQuantity] AS [Root - Physical Available Quantity] 
		,ipos.[OnOrderQuantity] AS [Root - On Order Quantity] 
		,ipos.[OrderedQuantity] AS [Root - Ordered Quantity] 
		,ipos.[OrderedReservedQuantity] AS [Root - Ordered Reserved Quantity] 
		,ipos.[TotalAvailableQuantity] AS [Root - Total Available Quantity] 
		,ipos.[PostedValueAtCost] AS [Root - Posted Value (at Cost)] 
		,ipos.[DeductedValueAtCost] AS [Root - Deducted Value (at Cost)] 
		,ipos.[ReceivedValueAtCost] AS [Root - Received Value (at Cost)] 
		,ipos.[PhysicalInventoryValueAtCost] AS [Root - Physical Inventory Value (at Cost)] 
		,ipos.[PhysicalReservedValueAtCost] AS [Root - Physical Reserved Value (at Cost)] 
		,ipos.[PhysicalAvailableValueAtCost] AS [Root - Physical Available Value (at Cost)] 
		,ipos.[OnOrderValueAtCost] AS [Root - On Order Value (at Cost)] 
		,ipos.[OrderedValueAtCost] AS [Root - Ordered Value (at Cost)] 
		,ipos.[OrderedReservedValueAtCost] AS [Root - Ordered Reserved Value (at Cost)] 
		,ipos.[TotalAvailableValueAtCost] AS [Root - Total Available Value (at Cost)] 
		,ipos.[ProductCost] AS [Root - Product Cost] 
		,ipos.[ShortShelfLifeInventoryQuantity] AS [Root - Short Shelf Life Inventory Quantity] 
		,ipos.[ShortShelfLifeInventoryAtCost] AS [Root - Short Shelf Life Inventory (at Cost)] 
		,ipos.[ExpiredInventoryQuantity] AS [Root - Expired Inventory Quantity] 
		,ipos.[ExpiredInventoryAtCost] AS [Root - Expired Inventory (at Cost)] 
		,ipos.[ArrivedQuantity] AS [Root - Arrived Quantity]
		,ipos.[PickedQuantity] AS [Root - Picked Quantity]
		,ipos.[OrderedAvailableQuantity] AS [Root - Ordered Available Quantity]
		,ipos.[ArrivedValueAtCost] AS [Root - Arrived Value (at Cost)]
		,ipos.[PickedValueAtCost] AS [Root - Picked Value (at Cost)]
		,ipos.[OrderedAvailableValueAtCost] AS [Root - Ordered Available Value (at Cost)]
		,b.[ETLBatchSeriesCreateDate] AS [Data Last Captured]
		,GETDATE() AS [Data Last Processed]

		/* Custom Fields */
		,ipos.[LicensePlateId] AS [Custom License Plate ID] 
		,ipos.CurrencyCode AS [Currency Code]

FROM	[Inventory].[gsInventoryPosition] AS ipos

		LEFT JOIN 
						(
						SELECT		ETLBatchSeriesID
									,MAX(ETLBatchSeriesCreateDate) AS ETLBatchSeriesCreateDate
						FROM		Config.gsEtlBatchSeries
						GROUP BY	ETLBatchSeriesID
						) AS b ON ipos.ETLBatchSeriesID = b.ETLBatchSeriesID

GO

