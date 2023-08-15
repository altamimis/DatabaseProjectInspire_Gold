/*===============================================================================================================
[Customer].[gsCustomer]
***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.
===============================================================================================================*/  

CREATE VIEW [Customer].[gsCustomer] 
AS 
SELECT  
		* 

FROM	OPENROWSET( BULK '/basecustomer', DATA_SOURCE = 'gold', FORMAT = 'DELTA' ) AS r

GO

