CREATE VIEW [Sales].[gmSalesOrder] 
AS 

/*===============================================================================================================
[Sales].[gmSalesOrder] 

***Proprietary & Confidential*** 
Copyright© 2022, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.

Updated By:	Jonathan Moelling
Updated On:	06/08/2023
Release:	2.0.0
Comments:	Added [Open Order Flag] and [Order Shipment Days Late].

Updated By:	Jonathan Moelling
Updated On:	06/28/2023
Release:	2.0.0
Comments:	Added [Actual Shipped Date] and [Root - Actual Shipped Quantity].

===============================================================================================================*/ 

SELECT		o.[SalesOrderPrimaryKey] AS [Sales Order Primary Key]
			,o.[SalesOrderCompanyKey] AS [Sales Order Company Key]
			,o.[SalesOrderProductKey] AS [Sales Order Product Key]
			,o.[SalesOrderCustomerKey] AS [Sales Order Customer Key]
			,o.[SalesOrderSourceSystemKey] AS [Sales Order Source System Key]
			,o.[SalesOrderInventoryLocationKey] AS [Sales Order Inventory Location Key]
			,CAST(CONVERT(CHAR(8), o.[OrderDate], 112) AS INT) AS [Order Date Key]
			,CAST(CAST(o.[OrderDate] AS DATE) AS DATETIME) AS [Order Date] 
			,o.[OrderID] AS [Order ID]
			,o.[OrderTypeID] AS [Order Type ID]
			,o.[OrderType] AS [Order Type]
			,o.[OrderLineID] AS [Order Line ID]
			,o.[OrderLineTypeID] AS [Order Line Type ID]
			,o.[OrderLineType] AS [Order Line Type]
			,o.[CustomerShipToNumber] AS [Customer Ship To Number]
			,o.[OrderStatus] AS [Order Status]
			,o.[OrderLineStatus] AS [Order Line Status]
			,o.[OrderQuantity] AS [Root - Order Quantity]
			,o.[OrderSalesQuantity] AS [Root - Order Sales Quantity]
			,o.[OrderLineAmount] AS [Root - Order Line Amount]
			,o.[OrderCurrencyCode] AS [Order Currency Code]
			,o.[OrderSalesCategory] AS [Order Sales Category]
			,o.[OrderSalesType] AS [Order Sales Type]
			,o.[OrderSalesPrice] AS [Order Sales Price]
			,o.[OrderSalesUnit] AS [Order Sales Unit]
			,o.[OrderPriceUnit] AS [Order Price Unit]
			,o.[OrderLineShipmentAddress] AS [Order Line Shipment Address]
			,o.[OrderLineShipmentZipCode] AS [Order Line Shipment Zip Code]
			,o.[OrderShipmentRequestedDate] AS [Order Shipment Requested Date]
			,o.[OrderShipmentConfirmedDate] AS [Order Shipment Confirmed Date]
			,o.[OrderReceiptRequestedDate] AS [Order Receipt Requested Date]
			,o.[OrderReceiptConfirmedDate] AS [Order Receipt Confirmed Date]
			,b.[ETLBatchSeriesCreateDate] AS [Data Last Captured]
			,GETDATE() AS [Data Last Processed]
			--,CASE WHEN o.[OrderShipmentConfirmedDate] = '1/1/1900' THEN 1 ELSE 0 END AS [Open Order Flag]
			--,CASE WHEN o.[OrderShipmentConfirmedDate] = '1/1/1900' AND o.[OrderShipmentRequestedDate] < CAST(GETDATE() AS DATE) 
			--		THEN DATEDIFF(d,o.[OrderShipmentRequestedDate], CAST(GETDATE() AS DATE))
			--	WHEN o.[OrderShipmentConfirmedDate] >= o.[OrderShipmentRequestedDate]
			--		THEN DATEDIFF(d,o.[OrderShipmentRequestedDate],o.[OrderShipmentConfirmedDate])
			--	END AS [Order Shipment Days Late]
			,CASE WHEN ISNULL(o.[ActualShippedDate],'1/1/1900') = '1/1/1900' THEN 1 ELSE 0 END AS [Open Order Flag]
			,CASE WHEN ISNULL(o.[OrderShipmentConfirmedDate],'1/1/1900') = '1/1/1900'
					THEN DATEDIFF(d,o.[OrderShipmentRequestedDate], ISNULL(o.[ActualShippedDate],CAST(GETDATE() AS DATE)))
				ELSE DATEDIFF(d,o.[OrderShipmentConfirmedDate], ISNULL(o.[ActualShippedDate],CAST(GETDATE() AS DATE)))
				END AS [Order Shipment Days Late]

			,CASE WHEN ISNULL([ActualShippedDate],'1/1/1900') <> '1/1/1900'
				THEN CASE WHEN [ActualShippedDate] <= 
						(CASE WHEN [OrderShipmentConfirmedDate] <> '1/1/1900'
								THEN [OrderShipmentConfirmedDate] ELSE [OrderShipmentRequestedDate] END)
								THEN 1
							ELSE 0
						END
					ELSE 0
			END AS [Shipped On Time Flag]
			
			,o.[ActualShippedQuantity] as [Root - Actual Shipped Quantity]
			,o.[ActualShippedDate] as [Actual Shipped Date]
			 
FROM		[Sales].[gsSalesOrder] AS o

			LEFT JOIN 
						(
						SELECT		ETLBatchSeriesID
									,MAX(ETLBatchSeriesCreateDate) AS ETLBatchSeriesCreateDate
						FROM		Config.gsEtlBatchSeries
						GROUP BY	ETLBatchSeriesID
						) AS b ON o.ETLBatchSeriesID = b.ETLBatchSeriesID

GO

