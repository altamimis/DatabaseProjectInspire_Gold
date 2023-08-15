/*===============================================================================================================
[SourceSystem].[gmSourceSystem] 
***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.
===============================================================================================================*/ 

CREATE VIEW [SourceSystem].[gmSourceSystem] 

AS 

SELECT
		 [SourceSystemPrimaryKey] AS [Source System Primary Key] 
		,[SourceSystemName] AS [Source System Name] 

FROM	[SourceSystem].[gsSourceSystem]

GO

