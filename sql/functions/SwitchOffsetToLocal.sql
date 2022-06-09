IF EXISTS (
    SELECT * FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'SwitchOffsetToLocal'
    AND ROUTINE_SCHEMA = 'dbo'
    AND ROUTINE_TYPE = 'FUNCTION'
)
BEGIN
    DROP FUNCTION [dbo].[SwitchOffsetToLocal];
END
GO

CREATE FUNCTION [dbo].[SwitchOffsetToLocal] 
(
	@datestamp DATETIMEOFFSET(7)
)
RETURNS DATETIMEOFFSET(7)
AS
BEGIN
	DECLARE @result DATETIMEOFFSET(7);
    SET @result = 
        switchoffset(@datestamp, datepart(tzoffset, sysdatetimeoffset()))
        --SWITCHOFFSET(@datestamp, DATENAME (TZoffset, SYSDATETIMEOFFSET()))
	RETURN @result;
END
GO
