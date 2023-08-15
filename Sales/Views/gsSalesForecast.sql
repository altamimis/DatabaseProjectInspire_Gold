/*===============================================================================================================
[Sales].[gsSalesForecast]
***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.
===============================================================================================================*/ 

CREATE VIEW [Sales].[gsSalesForecast] 
AS 
SELECT	* 

FROM	OPENROWSET( BULK '/basesalesforecast', DATA_SOURCE = 'gold', FORMAT = 'DELTA' ) AS r

GO

