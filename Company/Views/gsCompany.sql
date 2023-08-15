CREATE   VIEW [Company].[gsCompany] AS SELECT  * FROM OPENROWSET( BULK '/basecompany', DATA_SOURCE = 'gold', FORMAT = 'DELTA' ) AS r

GO

