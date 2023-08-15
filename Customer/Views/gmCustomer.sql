CREATE View [Customer].[gmCustomer]
AS

/*===============================================================================================================
[Company].[gmCustomer]
***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.

Updated By:	Darin Witten
Updated On:	04/08/2023
Release:	2.0.0
Comments:	Adding logic for "Data Last Captured" and "Data Last Processed".

===============================================================================================================*/  

SELECT	 c.[CustomerPrimaryKey] AS [Customer Primary Key]
		,c.[CustomerID] AS [Customer ID]
		,c.[CustomerName] AS [Customer Name]
		,c.[CustomerTypeID] AS [Customer Type ID]
		,c.[CustomerTypeName] AS [Customer Type Name]
		,c.[CustomerGroupID] AS [Customer Group ID]
		,c.[CustomerGroupName] AS [Customer Group Name]
		,c.[CustomerClassificationGroupID] AS [Customer Classification Group ID]
		,c.[CustomerClassificationGroupName] AS [Customer Classification Group Name]
		,c.[CustomerParentID] AS [Customer Parent ID]
		,c.[CustomerParentName] AS [Customer Parent Name]
		,c.[LineOfBusinessID] AS [Line Of Business ID]
		,c.[LineOfBusinessDescription] AS [Line Of Business Description]
		,c.[EmployeeResponsibleID] AS [Employee Responsible ID]
		,c.[EmployeeResponsibleName] AS [Employee Responsible Name]
		,c.[SegmentID] AS [Segment ID]
		,c.[SegmentDescription] AS [Segment Description]
		,c.[Subsegment] AS [Subsegment]
		,c.[SubsegmentDescription] AS [Subsegment Description]
		,c.[CompanyChainID] AS [Company Chain ID]
		,c.[CompanyChainName] AS [Company Chain Name]
		,c.[SalesDistrictID] AS [Sales District ID]
		,c.[SalesDistrictName] AS [Sales District Name]
		,c.[CustomerCompanyKey] AS [Customer Company Key]
		,c.[AddressID] AS [Address ID]
		,c.[Address] AS [Address]
		,c.[City] AS [City]
		,c.[County] AS [County]
		,c.[State] AS [State]
		,c.[Country] AS [Country]
		,c.[PostalCode] AS [Postal Code]
		,c.[SalesPoolName] AS [Sales Pool Name]
		,c.[CustomerSourceSystemKey] AS [Customer Source System Key]
		,b.[ETLBatchSeriesCreateDate] AS [Data Last Captured]
		,GETDATE() AS [Data Last Processed]
		
FROM	[Customer].[gsCustomer] AS c

		LEFT JOIN 
				(
				SELECT		ETLBatchSeriesID
							,MAX(ETLBatchSeriesCreateDate) AS ETLBatchSeriesCreateDate
				FROM		Config.gsEtlBatchSeries
				GROUP BY	ETLBatchSeriesID
				) AS b ON c.ETLBatchSeriesID = b.ETLBatchSeriesID

GO

