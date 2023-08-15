CREATE VIEW [Product].[gmProduct] 
AS 

/*===============================================================================================================
[Product].[gmProduct]
***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.

Updated By:	Darin Witten
Updated On:	04/08/2023
Release:	2.0.0
Comments:	Adding logic for "Data Last Captured" and "Data Last Processed".

===============================================================================================================*/ 

SELECT	 p.ProductPrimaryKey AS [Product Primary Key] 
		,p.ProductID AS [Product ID] 
		,p.ProductCompanyKey AS [Product Company Key] 
		,p.ProductNumber AS [Product Number] 
		,p.ProductName AS [Product Name] 
		,p.ProductDescription AS [Product Description] 
		,p.ProductType AS [Product Type] 
		,p.ProductTypeName AS [Product Type Name] 
		,p.Size AS [Size] 
		,p.Style AS [Style] 
		,p.Color AS [Color] 
		,p.ConfigID AS [Config ID] 
		,p.[Version] AS [Version] 
		,p.BaseUnitOfMeasureID AS [Base Unit Of Measure ID] 
		,p.BaseUnitOfMeasureName AS [Base Unit Of Measure Name] 
		,p.ShelfLifeDays AS [Shelf Life Days] 
		,p.ProductABCCode AS [Product ABC Code] 
		,p.ProductABCRevenueCode AS [Product ABC Revenue Code] 
		,p.ProductSourceSystemKey AS [Product Source System Key] 
		,CASE 
			WHEN 
				p.ConfigID IS NOT NULL 
				AND p.Color IS NOT NULL 
			THEN CONCAT(p.ConfigID, ' - ', p.Color) 
			ELSE NULL
		END AS [Configuration - Color]
		,CASE 
			WHEN 
				p.ConfigID IS NOT NULL 
				AND p.Color IS NOT NULL 
				AND p.Size IS NOT NULL 
			THEN CONCAT(p.ConfigID, ' - ', p.Color, ' - ', p.Size) 
		END AS [Configuration - Color - Size]
		,CASE
			WHEN p.ProductName IS NOT NULL 
			THEN CONCAT(p.ProductID, ' ', ProductName) 
		END AS [Product ID and Name]
		,b.[ETLBatchSeriesCreateDate] AS [Data Last Captured]
		,GETDATE() AS [Data Last Processed]

FROM	Product.gsProduct AS p

		LEFT JOIN 
						(
						SELECT		ETLBatchSeriesID
									,MAX(ETLBatchSeriesCreateDate) AS ETLBatchSeriesCreateDate
						FROM		Config.gsEtlBatchSeries
						GROUP BY	ETLBatchSeriesID
						) AS b ON p.ETLBatchSeriesID = b.ETLBatchSeriesID

GO

