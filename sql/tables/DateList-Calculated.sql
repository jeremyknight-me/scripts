SELECT TOP (1000) 
	[Date]
	,YEAR([Date]) as [Year]
	,DATEPART(QUARTER, [Date]) as [Quarter]
	,MONTH([Date]) as [Month]
	,DATENAME(MONTH, [Date]) as [MonthText]
	,DAY([Date]) as [Day]
	,DATENAME(DW, [Date]) as [DayText]
	,DATEPART(DW, [Date]) as [DayOfWeek]
	,DATEPART(ISO_WEEK, [Date]) as [WeekIso]
	,DATEPART(WEEK, [Date]) as [Week]
    ,[IsWeekday]
	-- different than ISO standard weeks must use 'week' date part
	,DATEADD(wk, DATEDIFF(wk,0,[Date]), 0) MondayOfCurrentWeek
	,DATEADD(wk, DATEDIFF(wk,0,[Date]), 1) TuesdayOfCurrentWeek
	,DATEADD(wk, DATEDIFF(wk,0,[Date]), 2) WednesdayOfCurrentWeek
	,DATEADD(wk, DATEDIFF(wk,0,[Date]), 3) ThursdayOfCurrentWeek
	,DATEADD(wk, DATEDIFF(wk,0,[Date]), 4) FridayOfCurrentWeek
	,DATEADD(wk, DATEDIFF(wk,0,[Date]), 5) SaturdayOfCurrentWeek
	,DATEADD(wk, DATEDIFF(wk,0,[Date]), 6) SundayOfCurrentWeek
FROM [Sandbox].[dbo].[DateList]
