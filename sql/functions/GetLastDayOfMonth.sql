/*
NOTES:
- With SQL Server 2012 or later, the EOMONTH() gives you a much more concise option
- Prior to SQL Server 2012, this is what typical T-SQL to compute last day of the month
*/
IF EXISTS
(
    SELECT * FROM INFORMATION_SCHEMA.ROUTINES
    WHERE   ROUTINE_NAME = 'GetLastDayOfMonth'
    AND ROUTINE_SCHEMA = 'dbo'
    AND ROUTINE_TYPE = 'FUNCTION'
)
BEGIN
    DROP FUNCTION dbo.GetLastDayOfMonth;
END
GO

CREATE FUNCTION dbo.GetLastDayOfMonth
(
	@date DATE
)
RETURNS DATE
AS
BEGIN
	DECLARE @result DATE = NULL;
	DECLARE @firstOfMonth DATE = DATEFROMPARTS(YEAR(@date), MONTH(@date), 1); 
	SELECT @result = DATEADD(DAY,-1, DATEADD(MONTH, 1, @firstOfMonth));
	RETURN @result;
END
GO

