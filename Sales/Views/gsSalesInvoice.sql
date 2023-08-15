/*===============================================================================================================
[Sales].[gsSalesInvoice]
***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.
===============================================================================================================*/ 

CREATE VIEW [Sales].[gsSalesInvoice] 
AS 
SELECT	* 

FROM	OPENROWSET( BULK '/basesalesinvoice', DATA_SOURCE = 'gold', FORMAT = 'DELTA' ) AS r

GO

