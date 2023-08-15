CREATE VIEW [Company].[gmCompany] 
AS 

/*===============================================================================================================
[Company].[gmCompany]
***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.

Updated By:	Darin Witten
Updated On:	04/08/2023
Release:	2.0.0
Comments:	Adding logic for "Data Last Captured" and "Data Last Processed".

===============================================================================================================*/  

SELECT   c.[CompanyPrimaryKey] AS [Company Primary Key] 
		,c.[CompanyCode] AS [Company Code] 
		,c.[CompanyName] AS [Company Name] 
		,c.[CompanySourceSystemKey] AS [Company Source System Key]
		,b.[ETLBatchSeriesCreateDate] AS [Data Last Captured]
		,GETDATE() AS [Data Last Processed]
		
FROM	[Company].[gsCompany] AS c

		LEFT JOIN 
						(
						SELECT		ETLBatchSeriesID
									,MAX(ETLBatchSeriesCreateDate) AS ETLBatchSeriesCreateDate
						FROM		Config.gsEtlBatchSeries
						GROUP BY	ETLBatchSeriesID
						) AS b ON c.ETLBatchSeriesID = b.ETLBatchSeriesID

WHERE	[CompanyPrimaryKey] IS NOT NULL

GO

