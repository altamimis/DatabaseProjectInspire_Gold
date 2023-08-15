CREATE   VIEW [Company].[gsExchangeRate] AS SELECT  * FROM OPENROWSET( BULK '/baseexchangerate', DATA_SOURCE = 'gold', FORMAT = 'DELTA' ) AS r     ;

GO

