IF EXISTS (
    SELECT * FROM dbo.sysobjects 
    WHERE 
        id = object_id(N'[dbo].[SwitchOffsetToLocal]') 
    AND xtype IN (N'FN', N'IF', N'TF')
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

IF EXISTS (
    SELECT * FROM dbo.sysobjects 
    WHERE 
        id = object_id(N'[dbo].[ConvertOffsetToLocalDateTime]') 
    AND xtype IN (N'FN', N'IF', N'TF')
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