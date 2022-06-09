SET NOCOUNT ON; -- turn off all the 1 row inserted messages

-- Set the date to start populating and end populating
DECLARE @beginDate DATETIME = '01/01/2010';
DECLARE @endDate DATETIME = '12/31/2010';

-- Start the counter at the begin date
DECLARE @dateCounter DATETIME = @beginDate; --Current date in loop

WHILE @dateCounter <= @endDate
BEGIN
    -- add a record into the date dimension table for this date
    INSERT INTO [dbo].MonthDimension
    (
        [ID],
        [MonthName],
        [CalendarQuarter]
    )
    VALUES  
    (
        MONTH(@dateCounter), --MonthOfYear
        DATENAME(mm, @dateCounter), --MonthName
        DATENAME(qq, @dateCounter) --CalendarQuarter      
    );
           
    -- Increment the date counter for next pass thru the loop
    SET @dateCounter = DATEADD(m, 1, @dateCounter);
END

SET NOCOUNT OFF; -- turn the messages back on