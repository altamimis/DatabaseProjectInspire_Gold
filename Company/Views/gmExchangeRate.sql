CREATE VIEW [Company].[gmExchangeRate] 
AS 

/*===============================================================================================================
[Company].[gmBaseExchangeRate]
***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.

Updated By:	Sultan Altamimi
Updated On:	05/15/2023
Release:	2.0.0
Comments:	pre-defined Exchange Rate table sourced from D365 F&O

Updated By:	Sultan Altamimi
Updated On:	06/07/2023
Release:	2.0.0
Comments:	Added Currency to Currency from fact tables 

Updated By:	Sultan Altamimi
Updated On:	06/27/2023
Release:	2.0.0
Comments:	Added exchange rate type and company key from ledger table amd modify calc
===============================================================================================================*/  

SELECT e.[ExchangeRatePrimaryKey]   AS [Exchange Rate Primary Key]
	 , e.[ExchangeRateCompanyKey]	AS [Exchange Rate Company Key]
     , e.[ExchangeRateKey]          AS [Exchange Rate Key]
     , e.[CurrencyExchangeRateKey]  AS [Currency Exchange Rate Key]
     , e.[ExchangeRate]             AS [Exchange Rate]
     , e.[ExchangeRateCurrencyPair] AS [Exchange Rate Currency Pair]
     , e.[FromCurrencyCode]         AS [From Currency Code]
     , e.[ToCurrencyCode]           AS [To Currency Code]
	 , CAST(CONVERT(CHAR(8), e.[ValidFromDate], 112) AS INT) AS [Valid From Date Key]
	 , CAST(CAST(e.[ValidFromDate] AS DATE) AS DATETIME)	 AS [Valid From Date] 
	 , CAST(CONVERT(CHAR(8), e.[ValidToDate], 112) AS INT)   AS [Valid To Date Key]
	 , CAST(CAST(e.[ValidToDate] AS DATE) AS DATETIME)       AS [Valid To Date] 
	 , e.[ExchangeRateType]									 AS [Exchange Rate Type]
     , b.[ETLBatchSeriesCreateDate] AS [Data Last Captured]
     , GETDATE()                    AS [Data Last Processed]
FROM [Company].[gsExchangeRate] AS e
    LEFT JOIN
    (
        SELECT ETLBatchSeriesID
             , MAX(ETLBatchSeriesCreateDate) AS ETLBatchSeriesCreateDate
        FROM Config.gsEtlBatchSeries
        GROUP BY ETLBatchSeriesID
    )                           AS b
        ON e.ETLBatchSeriesID = b.ETLBatchSeriesID
WHERE e.[ExchangeRatePrimaryKey] IS NOT NULL
UNION ALL
SELECT DISTINCT
    CONCAT(e.[FromCurrencyCode], '|', '1') AS [Exchange Rate Primary Key]
  , e.[ExchangeRateCompanyKey]			   AS [Exchange Rate Company Key]
  , 1                                      AS [Exchange Rate Key]
  , 1                                      AS [Currency Exchange Rate Key]
  , 1                                      AS [Exchange Rate]
  , 1                                      AS [Exchange Rate Currency Pair]
  , e.[FromCurrencyCode]                   AS [From Currency Code]
  , e.[FromCurrencyCode]                   AS [To Currency Code]
  , MIN(CAST(CONVERT(CHAR(8), e.[ValidFromDate], 112) AS INT)) AS [Valid From Date Key]
  , MIN(CAST(CAST(e.[ValidFromDate] AS DATE) AS DATETIME))	   AS [Valid From Date] 
  , MAX(CAST(CONVERT(CHAR(8), e.[ValidToDate], 112) AS INT))   AS [Valid To Date Key]
  , MAX(CAST(CAST(e.[ValidToDate] AS DATE) AS DATETIME))       AS [Valid To Date] 
  , 'Default'												   AS [Exchange Rate Type]
  , MAX(b.[ETLBatchSeriesCreateDate])      AS [Data Last Captured]
  , GETDATE()                              AS [Data Last Processed]
FROM
(
    SELECT DISTINCT
        [OrderCurrencyCode]  AS [FromCurrencyCode]
      , ETLBatchSeriesID
      , OrderDate            AS [ValidFromDate]
      , OrderDate            AS [ValidToDate]
	  , SalesOrderCompanyKey AS [ExchangeRateCompanyKey]
    FROM [Sales].[gsSalesOrder]
    UNION
    SELECT DISTINCT
        [SalesForecastCurrencyCode] AS [FromCurrencyCode]
      , ETLBatchSeriesID
      , SalesForecastDate           AS [ValidFromDate]
      , SalesForecastDate           AS [ValidToDate]
	  , SalesForecastCompanyKey		AS [ExchangeRateCompanyKey]
    FROM [Sales].[gsSalesForecast]
    UNION
    SELECT DISTINCT
        [CurrencyCode]  AS [FromCurrencyCode]
      , ETLBatchSeriesID
      , InvoiceDate     AS [ValidFromDate]
      , InvoiceDate     AS [ValidToDate]
	  , SalesInvoiceCompanyKey AS [ExchangeRateCompanyKey]
    FROM [Sales].[gsSalesInvoice]
	UNION
    SELECT DISTINCT
        [CurrencyCode]  AS [FromCurrencyCode]
      , ETLBatchSeriesID
      , InventoryPositionCaptureDate     AS [ValidFromDate]
      , InventoryPositionCaptureDate     AS [ValidToDate]
	  , InventoryPositionCompanyKey		 AS [ExchangeRateCompanyKey]
    FROM [Inventory].[gsInventoryPosition]
)     AS e
    LEFT JOIN
    (
        SELECT ETLBatchSeriesID
             , MAX(ETLBatchSeriesCreateDate) AS ETLBatchSeriesCreateDate
        FROM Config.gsEtlBatchSeries
        GROUP BY ETLBatchSeriesID
    ) AS b
        ON e.ETLBatchSeriesID = b.ETLBatchSeriesID
WHERE  e.[FromCurrencyCode] IS NOT NULL
GROUP BY e.[FromCurrencyCode], e.[ExchangeRateCompanyKey]

GO

