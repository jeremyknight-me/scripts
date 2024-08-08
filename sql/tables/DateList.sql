IF OBJECT_ID('DateList', 'U') IS NOT NULL
BEGIN
    DROP TABLE [dbo].DateList
END
GO

/* --- create table -------------------- */

CREATE TABLE dbo.DateList  
(  
    [Date] DATE NOT NULL,
    [Year] SMALLINT NOT NULL,  
    --YearFiscal SMALLINT NOT NULL,  
    [Quarter] TINYINT NOT NULL,  
    -- need fiscal quarter
    [Month] TINYINT NOT NULL,  
    [MonthText] VARCHAR(9) NOT NULL,
    [Day] TINYINT NOT NULL,  
    [DayText] VARCHAR(9) NOT NULL, 
    [DateOfWeek] TINYINT NOT NULL,     
    [Week] TINYINT NOT NULL,
    [WeekIso] TINYINT NOT NULL,
    IsWeekday BIT NOT NULL
);

/* --- insert number of records -------------------- */

INSERT dbo.DateList
(
    [Date], 
    [Year], 
    --YearFiscal SMALLINT,
    [Quarter],  
    -- need fiscal quarter
    [Month],  
    [MonthText],
    [Day],  
    [DayText], 
    [DateOfWeek],     
    [Week],
    [WeekIso],
    IsWeekday
) 
SELECT
    a1.[Date],
    [Year] = YEAR(a1.[Date]),
    --FiscalYear = YEAR(dt), 
    /* 
    -- if our fiscal year starts on May 1st: 
    FY = CASE  
        WHEN MONTH(dt) < 5 
        THEN YEAR(dt)-1  
        ELSE YEAR(dt) END, 
    */
    [Quarter] = DATEPART(QUARTER, a1.[Date]),
    --[FiscalQuarter] = CASE 
    --    WHEN MONTH([Date]) <= 3 THEN 1 
    --    WHEN MONTH([Date]) <= 6 THEN 2 
    --    WHEN MONTH([Date]) <= 9 THEN 3 
    --    ELSE 4 END,  
    [Month] = MONTH(a1.[Date]),
    [MonthText] = DATENAME(MONTH, a1.[Date]),
    [Day] = DAY(a1.[Date]),  
    [DayText] = DATENAME(DW, a1.[Date]),  
    [DateOfWeek] = DATEPART(DW, a1.[Date]),  
    [Week] = DATEPART(WEEK, a1.[Date]),
    [WeekIso] = DATEPART(ISO_WEEK, a1.[Date]),
    IsWeekday = CASE  
        WHEN DATEPART(DW, a1.[Date]) IN (1,7) THEN 0 
        ELSE 1 
    END
FROM dbo.NumberList
    CROSS APPLY (VALUES(
	    DATEADD(DAY, Number, '1989-12-31')
    )) a1([Date])
WHERE Number <= 21915 -- ends on last day of 2049
ORDER BY Number;

-- /* --- Week Start (monday of week) --------------- */
-- DATEADD(wk, DATEDIFF(wk,0,[Date]), 0) MondayOfCurrentWeek

/* --- Add PK -------------------------------- */

ALTER TABLE dbo.DateList ADD CONSTRAINT PK_DateList PRIMARY KEY CLUSTERED ([Date]);
