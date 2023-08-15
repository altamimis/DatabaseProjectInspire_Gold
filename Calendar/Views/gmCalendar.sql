CREATE VIEW [Calendar].[gmCalendar]
AS 

/*===============================================================================================================

[Calendar].[gmCalendar]

***Proprietary & Confidential*** 
Copyright© 2023, MCA Connect - ALL RIGHTS RESERVED 
This code is licensed under the terms and conditions contained within the MCA Connect End User License Agreement.

Created By:	Darin Witten
Created On:	04/08/2023
Version:	2.0.0
Comments:	This view should combine Calendar information from the "gs" source view and the "gc" custom view
			if one exists. This view serves as the source for the Power BI Dataset.

===============================================================================================================*/ 

SELECT		[Calendar Primary Key]
			,[Calendar ID]
			,[Calendar Name]
			,[Calendar Type]
			,[Date Key]
			,[Date]
			,[Day Of Week]
			,[Day Of Week Abbr]
			,[Day Of Week Number]
			,[Day Of Month Number]
			,[Day Of Quarter Number]
			,[Day Of Year Number]
			,[Day Sequence Number]
			,[Week]
			,[Week (Abbr)]
			,[Week Number]
			,[Week Sequence Number]
			,[Month]
			,[Month (Abbr)]
			,[Month Number]
			,[Month Sequence Number]
			,[Quarter]
			,[Quarter (Abbr)]
			,[Quarter Number]
			,[Quarter Sequence Number]
			,[Year]
			,[Year (Abbr)]
			,[Year Number]
			,[Week Begin Date]
			,[Week End Date]
			,[Month Begin Date]
			,[Month End Date]
			,[Quarter Begin Date]
			,[Quarter End Date]
			,[Year Begin Date]
			,[Year End Date]
			,[Date PY]
			,[Working Day Flag]
			,[Holiday Flag]
			,[Holiday]
			,[Relative Day]
			,[Relative Week]
			,[Relative Month]
			,[Relative Quarter]
			,[Relative Year]
			,[Year Month]
			,[Month Year (Abbr)]
			,GETDATE() AS [Data Last Captured]
			,GETDATE() AS [Data Last Processed]
			,[Calendar Source System Key]

FROM		[Calendar].[gsCalendar]

GO

