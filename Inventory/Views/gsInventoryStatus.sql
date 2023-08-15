/*===============================================================================================================
[Inventory].[gsInventoryLocation]
***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.
===============================================================================================================*/ 




CREATE   VIEW [Inventory].[gsInventoryStatus] 
AS 
SELECT  * 

FROM	OPENROWSET( BULK '/baseinventorystatus', DATA_SOURCE = 'gold', FORMAT = 'DELTA' ) AS r

GO

