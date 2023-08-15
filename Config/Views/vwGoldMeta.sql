/*===============================================================================================================
[Config].[vwGoldMeta]
***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.
===============================================================================================================*/ 

CREATE VIEW [Config].[vwGoldMeta] 
AS 
SELECT  
		* 

FROM	OPENROWSET( BULK '/goldmeta', DATA_SOURCE = 'configs', FORMAT = 'DELTA' ) AS r

GO

