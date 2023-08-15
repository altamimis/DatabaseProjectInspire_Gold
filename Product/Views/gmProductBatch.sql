CREATE VIEW [Product].[gmProductBatch] 
AS 

/*===============================================================================================================
[Product].[gmProductBatch]
***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.

Updated By:	Darin Witten
Updated On:	04/08/2023
Release:	2.0.0
Comments:	Adding logic for "Data Last Captured" and "Data Last Processed".

===============================================================================================================*/ 

SELECT	 pb.[ProductBatchPrimaryKey] AS [Product Batch Primary Key] 
		,pb.[ProductBatchID] AS [Product Batch ID] 
		,pb.[ProductBatchCompanyKey] AS [Product Batch Company Key] 
		,pb.[ProductBatchProductKey] AS [Product Batch Product Key] 
		,pb.[ProductionDate] AS [Production Date] 
		,pb.[BestBeforeDate] AS [Best Before Date] 
		,pb.[ExpirationDate] AS [Expiration Date] 
		,pb.[ProductBatchSourceSystemKey] AS [Product Batch Source System Key]
		,b.[ETLBatchSeriesCreateDate] AS [Data Last Captured]
		,GETDATE() AS [Data Last Processed]

FROM	[Product].[gsProductBatch] AS pb

		LEFT JOIN 
					(
					SELECT		ETLBatchSeriesID
								,MAX(ETLBatchSeriesCreateDate) AS ETLBatchSeriesCreateDate
					FROM		Config.gsEtlBatchSeries
					GROUP BY	ETLBatchSeriesID
					) AS b ON pb.ETLBatchSeriesID = b.ETLBatchSeriesID

WHERE	pb.[ProductBatchID] IS NOT NULL

GO

