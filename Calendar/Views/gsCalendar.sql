CREATE VIEW [Calendar].[gsCalendar] 
AS 

/*===============================================================================================================

[Calendar].[gsCalendar]

***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.

Created By:	Darin Witten
Created On:	04/08/2023
Version:	2.0.0
Comments:	This logic is replacing the DAX formula in the Power BI Dataset for Calendar. Values for Historical
			and Future Years should be updated here based on Customer preference.

===============================================================================================================*/ 

WITH CTE_N1
AS		(
		SELECT		ROW_NUMBER() OVER(PARTITION BY '' ORDER BY N) AS N
		FROM		(
					SELECT	TOP 100000 1 AS N
					FROM	sys.all_columns AS A
							CROSS APPLY sys.all_columns AS B
					) A
		) 

,CTE_Tally
AS
		(
		SELECT		ROW_NUMBER() OVER(PARTITION BY '' ORDER BY N) AS N
		FROM		CTE_N1
		)

,CTE_Dates
AS
		(
		SELECT		DATEADD(DD, 50000 - N, CAST(GETDATE() AS DATE)) AS CalendarDate
		FROM		CTE_Tally
		WHERE		DATEADD(DD, 50000 - N, CAST(GETDATE() AS DATE)) BETWEEN '1/1/1900' AND '12/31/2099'
		)

/* Calendar ID = 'A'; Calendar Name = 'Base'; Calendar Type = 'Gregorian' */

SELECT		 CONCAT('A', CONVERT(CHAR(8), CalendarDate, 112)) AS [Calendar Primary Key]
			,'A' AS [Calendar ID]
			,'Base' AS [Calendar Name]
			,'Gregorian' AS [Calendar Type]
			,CAST(CONVERT(CHAR(8), CalendarDate, 112) AS INT) AS [Date Key]
			,CalendarDate AS [Date]
			,DATENAME(DW, CalendarDate) AS [Day Of Week]
			,LEFT(DATENAME(DW, CalendarDate), 3) AS [Day Of Week Abbr]
			,DATEPART(DW, CalendarDate) AS [Day Of Week Number]
			,DAY(CalendarDate) AS [Day Of Month Number]
			,DATEDIFF(DD, DATEADD(q, DATEDIFF(q, 0, CalendarDate),0), CalendarDate) + 1 AS [Day Of Quarter Number]
			,DATEPART(DY, CalendarDate) AS [Day Of Year Number]
			,DATEDIFF(DD, CAST(CONCAT('1/1/', YEAR(GETDATE()) - 10) AS DATE), CalendarDate) + 1 AS [Day Sequence Number] /* Based on Historical Years = 10 */
			,CONCAT('Week ', DATEPART(WEEK, CalendarDate)) AS [Week]
			,CONCAT('Wk ', DATEPART(WEEK, CalendarDate)) AS [Week (Abbr)]
			,DATEPART(WEEK, CalendarDate) AS [Week Number]
			,DATEDIFF(WEEK, CAST(CONCAT('1/1/', YEAR(GETDATE()) - 10) AS DATE), CalendarDate) + 1 AS [Week Sequence Number] /* Based on Historical Years = 10 */
			,DATENAME(M, CalendarDate) AS [Month]
			,LEFT(DATENAME(M, CalendarDate), 3) AS [Month (Abbr)]
			,DATEPART(M, CalendarDate) AS [Month Number]
			,DATEDIFF(MONTH, CAST(CONCAT('1/1/', YEAR(GETDATE()) - 10) AS DATE), CalendarDate) + 1 AS [Month Sequence Number] /* Based on Historical Years = 10 */
			,CONCAT('Quarter ', DATEPART(QUARTER, CalendarDate)) AS [Quarter]
			,CONCAT('Q', DATEPART(QUARTER, CalendarDate)) AS [Quarter (Abbr)]
			,DATEPART(QUARTER, CalendarDate) AS [Quarter Number]
			,DATEDIFF(QUARTER, CAST(CONCAT('1/1/', YEAR(GETDATE()) - 10) AS DATE), CalendarDate) + 1 AS [Quarter Sequence Number] /* Based on Historical Years = 10 */
			,YEAR(CalendarDate) AS [Year]
			,RIGHT(YEAR(CalendarDate), 2) AS [Year (Abbr)]
			,YEAR(CalendarDate) AS [Year Number]
			,DATEADD(DAY, (DATEPART(DW, CalendarDate) - 1) * -1, CalendarDate) AS [Week Begin Date]
			,DATEADD(DAY, (DATEPART(DW, CalendarDate) - 7) * -1, CalendarDate) AS [Week End Date]
			,DATEADD(DAY, (DAY(CalendarDate) - 1) * -1, CalendarDate) AS [Month Begin Date]
			,EOMONTH(CalendarDate) AS [Month End Date]
			,CAST(CONCAT((DATEPART(QUARTER, CalendarDate) * 3) - 2, '/1/', DATEPART(YEAR, CalendarDate)) AS DATE) AS [Quarter Begin Date]
			,EOMONTH(CAST(CONCAT(DATEPART(QUARTER, CalendarDate) * 3, '/1/', DATEPART(YEAR, CalendarDate)) AS DATE)) AS [Quarter End Date]
			,CAST(CONCAT('1/1/', YEAR(CalendarDate)) AS DATE) AS [Year Begin Date]
			,CAST(CONCAT('12/31/', YEAR(CalendarDate)) AS DATE) AS [Year End Date]
			,DATEADD(DAY, -365, CalendarDate) AS [Date PY]
			,CASE WHEN DATEPART(DW, CalendarDate) BETWEEN 2 AND 6 THEN 1 ELSE 0 END AS [Working Day Flag]
			,0 AS [Holiday Flag]
			,'' AS [Holiday]
			,DATEDIFF(day, CAST(GETDATE() AS DATE), CalendarDate) AS [Relative Day]
			,((YEAR(CalendarDate) - YEAR(CAST(GETDATE() AS DATE))) * 52) + (DATEPART(WEEK, CalendarDate) - DATEPART(WEEK, CAST(GETDATE() AS DATE))) AS [Relative Week]
			,((YEAR(CalendarDate) - YEAR(CAST(GETDATE() AS DATE))) * 12) + (DATEPART(M, CalendarDate) - DATEPART(M, CAST(GETDATE() AS DATE))) AS [Relative Month]
			,((YEAR(CalendarDate) - YEAR(CAST(GETDATE() AS DATE))) * 4) + (DATEPART(QUARTER, CalendarDate) - DATEPART(QUARTER, CAST(GETDATE() AS DATE))) AS [Relative Quarter]
			,(YEAR(CalendarDate) - YEAR(CAST(GETDATE() AS DATE))) AS [Relative Year]
			,FORMAT(CalendarDate,'yyyy-MM') AS [Year Month]
			,FORMAT(CalendarDate,'MMM-yyyy') AS [Month Year (Abbr)]
			,1 AS [Calendar Source System Key]

FROM		CTE_Dates

WHERE		CalendarDate BETWEEN CAST(CONCAT('1/1/', YEAR(GETDATE()) - 10) AS DATE)  /* Based on Historical Years = 10 */ AND CAST(CONCAT('12/31/', YEAR(GETDATE()) + 10) AS DATE) /* Based on Future Years = 10 */

GO

