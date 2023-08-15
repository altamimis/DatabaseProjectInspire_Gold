/*===============================================================================================================
[Sales].[gsSalesInvoice]
***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.
===============================================================================================================*/ 

CREATE VIEW [Config].[gsEtlBatchSeries] 
AS 
SELECT	* 

FROM	OPENROWSET( BULK '/etlbatchseries', DATA_SOURCE = 'configs', FORMAT = 'DELTA' ) AS r

GO

