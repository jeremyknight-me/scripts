IF EXISTS (
    SELECT * FROM INFORMATION_SCHEMA.ROUTINES
    WHERE   ROUTINE_NAME = 'GetIsoWeek'
    AND ROUTINE_SCHEMA = 'dbo'
    AND ROUTINE_TYPE = 'FUNCTION'
)
BEGIN
    DROP FUNCTION [dbo].[GetIsoWeek];
END
GO

CREATE FUNCTION dbo.GetIsoWeek 
( 
    @dt DATE 
) 
RETURNS TINYINT 
AS 
BEGIN 
    DECLARE @isoWeek TINYINT;
 
    SET @isoWeek = DATEPART(WEEK,@dt)+1 
        -DATEPART(WEEK,RTRIM(YEAR(@dt))+'0104');
 
    IF @isoWeek = 0 
    BEGIN 
        SET @ISOweek = dbo.GetIsoWeek( 
            RTRIM(YEAR(@dt)-1)+'12'+RTRIM(24+DAY(@dt)) 
        ) + 1;
    END 
 
    IF MONTH(@dt) = 12 AND DAY(@dt)-DATEPART(DW,@dt) >= 28 
    BEGIN 
        SET @isoWeek=1;
    END 
 
    RETURN(@isoWeek);
END 
GO