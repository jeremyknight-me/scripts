IF EXISTS (
    SELECT * FROM INFORMATION_SCHEMA.ROUTINES
    WHERE   ROUTINE_NAME = 'ConvertOffsetToLocalDateTime'
    AND ROUTINE_SCHEMA = 'dbo'
    AND ROUTINE_TYPE = 'FUNCTION'
)
BEGIN
    DROP FUNCTION [dbo].[ConvertOffsetToLocalDateTime];
END
GO

CREATE FUNCTION [dbo].[ConvertOffsetToLocalDateTime] 
(
	@datestamp datetimeoffset(7)
)
RETURNS datetime
AS
BEGIN
	DECLARE @result datetime;
	SET @result = CONVERT(datetime,dbo.SwitchOffsetToLocal(@datestamp));
	RETURN @result;
END
GO
