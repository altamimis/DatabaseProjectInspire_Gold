CREATE VIEW [Sales].[gmSalesInvoice] 
AS 

/*===============================================================================================================
[Sales].[gmSalesInvoice] 
***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.

Updated By: Zach Figueroa	
Updated Date: 11/28/2022
Description: Added left join to the Config.gsETLBatchSeries for the partitioning that is in place.

Updated By:	Darin Witten
Updated On:	04/08/2023
Release:	2.0.0
Comments:	Adding logic for "Data Last Captured" and "Data Last Processed".
			Updated the "Invoice Date" column to ShortDate format.

Updated By:	Jonathan Moelling
Updated On:	05/23/2023
Release:	2.0.0
Comments:	Replaced [Sales Invoice Calendar Key] and [Sales Order Calendar Key] with 
			[Invoice Date Key] and [Order Date Key].

===============================================================================================================*/ 

SELECT	 i.[SalesInvoiceCompanyKey] AS [Sales Invoice Company Key]
		,i.[SalesInvoiceProductKey] AS [Sales Invoice Product Key] 
		,i.[SalesInvoiceCustomerKey] AS [Sales Invoice Customer Key] 
		,i.[SalesInvoicePrimaryKey] AS [Sales Invoice Primary Key]
		,CAST(CONVERT(CHAR(8), i.[InvoiceDate], 112) AS INT) AS [Invoice Date Key]
		,CAST(CAST(i.[InvoiceDate] AS DATE) AS DATETIME) AS [Invoice Date] 
		,CAST(CONVERT(CHAR(8), i.[OrderDate], 112) AS INT) AS [Order Date Key]
		,CAST(CAST(i.[OrderDate] AS DATE) AS DATETIME) AS [Order Date] 
		,i.[SalesInvoiceInventoryLocationKey] AS [Sales Invoice Inventory Location Key] 
		,i.[SalesInvoiceSourceSystemKey] AS [Sales Invoice Source System Key] 
		,i.[InvoiceID] AS [Invoice ID] 
		,i.[InvoiceTypeID] AS [Invoice Type ID] 
		,i.[InvoiceType] AS [Invoice Type] 
		,i.[InvoiceLineID] AS [Invoice Line ID] 
		,i.[InvoiceLineTypeID] AS [Invoice Line Type ID] 
		,i.[InvoiceLineType] AS [Invoice Line Type] 
		,i.[OrderID] AS [Order ID] 
		,i.[OrderTypeID] AS [Order Type ID] 
		,i.[OrderType] AS [Order Type] 
		,i.[OrderLineID] AS [Order Line ID] 
		,i.[OrderLineTypeID] AS [Order Line Type ID] 
		,i.[OrderLineType] AS [Order Line Type] 
		,i.[Quantity] AS [Root - Sales Quantity] 
		,i.[UnitCost] AS [Unit Cost] 
		,i.[CostTotal] AS [Root - Cost Amount] 
		,i.[CostAdjustmentTotal] AS [Root - Cost Adjustment Amount] 
		,i.[UnitPrice] AS [Unit Price] 
		,i.[SalesPrice] AS [Sales Price] 
		,i.[SalesTotal] AS [Root - Sales Amount] 
		,i.[SalesTax] AS [Root - Sales Tax] 
		,i.[CurrencyCode] AS [Currency Code] 
		,i.[Discount] AS [Root - Discount Amount] 
		,i.[ChargeAmount] AS [Root - Charge Amount] 
		,i.[ChargeType] AS [Charge Type] 
		,i.[DefaultDimension] AS [Default Dimension] 

		--Partitioning
		,b.[ETLBatchSeriesCreateDate] AS [ETL Batch Series Create Date]

		,b.[ETLBatchSeriesCreateDate] AS [Data Last Captured]
		,GETDATE() AS [Data Last Processed]

FROM	[Sales].[gsSalesInvoice] AS i
	
		
		LEFT JOIN 
					(
					SELECT		ETLBatchSeriesID
								,MAX(ETLBatchSeriesCreateDate) AS ETLBatchSeriesCreateDate
					FROM		Config.gsEtlBatchSeries
					GROUP BY	ETLBatchSeriesID

					) AS b ON i.ETLBatchSeriesID = b.ETLBatchSeriesID

GO

