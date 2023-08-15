/*===============================================================================================================
[SourceSystem].[gsSourceSystem]
***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.
===============================================================================================================*/ 

CREATE VIEW [SourceSystem].[gsSourceSystem] 
AS 
SELECT	* 

FROM	OPENROWSET( BULK '/basesourcesystem', DATA_SOURCE = 'gold', FORMAT = 'DELTA' ) AS r

GO

