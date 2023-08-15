CREATE VIEW [Sales].[gsSalesOrder]
AS

/*===============================================================================================================
[Sales].[gsSalesOrder]
	
***Proprietary & Confidential***
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.
	
===============================================================================================================*/
	
SELECT		*
	
FROM		OPENROWSET(BULK '/basesalesorder', DATA_SOURCE = 'gold', FORMAT = 'DELTA' ) AS r

GO

