IF OBJECT_ID('DateList', 'U') IS NOT NULL
BEGIN
    DROP TABLE [dbo].DateList
END
GO

/* --- create table -------------------- */

CREATE TABLE dbo.DateList  
(  
    [Date] DATE NOT NULL,
    [Year] SMALLINT,  
    --YearFiscal SMALLINT,  
    [Quarter] TINYINT,  
	-- need fiscal quarter
	[Month] TINYINT,  
	[MonthText] VARCHAR(9),
    [Day] TINYINT,  
	[DayText] VARCHAR(9), 
    [DateOfWeek] TINYINT,     
    [Week] TINYINT,
	[WeekIso] TINYINT,
	IsWeekday BIT
);

/* --- insert number of record -------------------- */

INSERT dbo.DateList([Date]) 
SELECT DATEADD(DAY, Number, '2009-12-31') 
FROM dbo.NumberList
WHERE Number <= 10957 -- ends on last day of 2039
ORDER BY Number;

/* --- add data for simple columns -------------------- */

UPDATE dbo.DateList 
SET 
    [Year] = YEAR([Date]),
    --FiscalYear = YEAR(dt), 
    /* 
    -- if our fiscal year starts on May 1st: 
    FY = CASE  
        WHEN MONTH(dt) < 5 
        THEN YEAR(dt)-1  
        ELSE YEAR(dt) END, 
    */
	[Quarter] = DATEPART(QUARTER, [Date]),
    --[FiscalQuarter] = CASE 
    --    WHEN MONTH([Date]) <= 3 THEN 1 
    --    WHEN MONTH([Date]) <= 6 THEN 2 
    --    WHEN MONTH([Date]) <= 9 THEN 3 
    --    ELSE 4 END,  
    [Month] = MONTH([Date]),  
    [MonthText] = DATENAME(MONTH, [Date]),
	[Day] = DAY([Date]),  
    [DayText] = DATENAME(DW, [Date]),  
	[DateOfWeek] = DATEPART(DW, [Date]),  
    [Week] = DATEPART(WEEK, [Date]),
	[WeekIso] = DATEPART(ISO_WEEK, [Date]),
	IsWeekday = CASE  
        WHEN DATEPART(DW, [Date]) IN (1,7) THEN 0 
        ELSE 1 
    END;

-- /* --- Week Start (monday of week) --------------- */
-- DATEADD(wk, DATEDIFF(wk,0,[Date]), 0) MondayOfCurrentWeek

/* --- Add PK -------------------------------- */

ALTER TABLE dbo.DateList ADD CONSTRAINT PK_DateList PRIMARY KEY CLUSTERED ([Date]);