SET NOCOUNT ON; -- turn off all the 1 row inserted messages

DECLARE @beginDate DATETIME;
DECLARE @endDate DATETIME;
DECLARE @lastDayOfMonth BIT;

-- Number of months to add to the date to get the current Fiscal date
DECLARE @fiscalYearMonthsOffset INT;

-- These two counters are used in our loop.
DECLARE @dateCounter DATETIME;    --Current date in loop
DECLARE @fiscalCounter DATETIME;  --Fiscal Year Date in loop

-- Set the date to start populating and end populating
SET @beginDate = '01/01/2015';
SET @endDate = '12/31/2030';

-- Set this to the number of months to add to the current date to get
-- the beginning of the Fiscal year. For example, if the Fiscal year
-- begins July 1, put a 6 there.
-- Negative values are also allowed, thus if your 2010 Fiscal year
-- begins in July of 2009, put a -6.
SET @fiscalYearMonthsOffset = 0;

-- Start the counter at the begin date
SET @dateCounter = @beginDate;

WHILE @dateCounter <= @endDate
BEGIN
    -- Calculate the current Fiscal date as an offset of the current date in the loop
    SET @fiscalCounter = DATEADD(m, @fiscalYearMonthsOffset, @dateCounter);

    -- Set value for IsLastDayOfMonth
    IF MONTH(@dateCounter) = MONTH(DATEADD(d, 1, @dateCounter))
    BEGIN
       SET @lastDayOfMonth = 0;
    END
    ELSE
    BEGIN
       SET @lastDayOfMonth = 1; 
    END

    -- add a record into the date dimension table for this date
    INSERT INTO [dbo].[DateDimension]
    (
		[Id],
        [DateStamp],
        [DateName],
        [DateNameUS],
        [DateNameEU],
        [DayOfWeek],
        [DayNameOfWeek],
        [DayOfMonth],
        [DayOfYear],
        [IsWeekday],
        [WeekOfYear],
        [MonthName],
        [MonthOfYear],
        [IsLastDayOfMonth],
        [CalendarQuarter],
        [CalendarYear],
        [CalendarYearMonth],
        [CalendarYearQtr],
        [FiscalMonthOfYear],
        [FiscalQuarter],
        [FiscalYear],
        [FiscalYearMonth],
        [FiscalYearQtr]
    )
    VALUES  
    (
		CONVERT(int,
			CAST(YEAR(@dateCounter) AS CHAR(4)) 
            + RIGHT('00' + RTRIM(CAST(DATEPART(mm, @dateCounter) AS CHAR(2))), 2)
			+ RIGHT('00' + RTRIM(CAST(DATEPART(dd, @dateCounter) AS CHAR(2))), 2)
		), 
        @dateCounter, -- DateStamp
        CAST(YEAR(@dateCounter) AS CHAR(4)) + '-'
            + RIGHT('00' + RTRIM(CAST(DATEPART(mm, @dateCounter) AS CHAR(2))), 2) + '-'
            + RIGHT('00' + RTRIM(CAST(DATEPART(dd, @dateCounter) AS CHAR(2))), 2), --DateName
        RIGHT('00' + RTRIM(CAST(DATEPART(mm, @dateCounter) AS CHAR(2))), 2) + '-'
            + RIGHT('00' + RTRIM(CAST(DATEPART(dd, @dateCounter) AS CHAR(2))), 2)  + '-'
            + CAST(YEAR(@dateCounter) AS CHAR(4)), --DateNameUS
        RIGHT('00' + RTRIM(CAST(DATEPART(dd, @dateCounter) AS CHAR(2))), 2) + '-'
            + RIGHT('00' + RTRIM(CAST(DATEPART(mm, @dateCounter) AS CHAR(2))), 2)  + '-'
            + CAST(YEAR(@dateCounter) AS CHAR(4)), --DateNameEU
        DATEPART(dw, @dateCounter), --DayOfWeek
        DATENAME(dw, @dateCounter), --DayNameOfWeek
        DATENAME(dd, @dateCounter), --DayOfMonth
        DATENAME(dy, @dateCounter), --DayOfYear
        CASE DATENAME(dw, @dateCounter)
            WHEN 'Saturday' THEN 0
            WHEN 'Sunday' THEN 0
            ELSE 1
        END, --WeekdayWeekend    
        DATENAME(ww, @dateCounter), --WeekOfYear
        DATENAME(mm, @dateCounter), --MonthName
        MONTH(@dateCounter), --MonthOfYear
        @lastDayOfMonth, --IsLastDayOfMonth
        DATENAME(qq, @dateCounter), --CalendarQuarter
        YEAR(@dateCounter), --CalendarYear
        CAST(YEAR(@dateCounter) AS CHAR(4)) + '-'
            + RIGHT('00' + RTRIM(CAST(DATEPART(mm, @dateCounter) AS CHAR(2))), 2), --CalendarYearMonth      
        CAST(YEAR(@dateCounter) AS CHAR(4)) + 'Q' + CAST(DATENAME(qq, @dateCounter) AS CHAR(1)), --CalendarYearQtr        
        MONTH(@fiscalCounter), --FiscalMonthOfYear
        DATENAME(qq, @FiscalCounter), --FiscalQuarter      
        YEAR(@fiscalCounter), --FiscalYear
        CAST(YEAR(@fiscalCounter) AS CHAR(4)) + '-'
            + RIGHT('00' + RTRIM(CAST(DATEPART(mm, @fiscalCounter) AS CHAR(2))), 2), --FiscalYearMonth
        CAST(YEAR(@fiscalCounter) AS CHAR(4)) + 'Q' + CAST(DATENAME(qq, @fiscalCounter) AS CHAR(1)) --FiscalYearQtr        
    );
           
    -- Increment the date counter for next pass thru the loop
    SET @dateCounter = DATEADD(d, 1, @dateCounter);
END

SET NOCOUNT OFF; -- turn the annoying messages back on