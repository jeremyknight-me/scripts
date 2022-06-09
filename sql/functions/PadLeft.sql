IF EXISTS (
    SELECT * FROM INFORMATION_SCHEMA.ROUTINES
    WHERE   ROUTINE_NAME = 'PadLeft'
    AND ROUTINE_SCHEMA = 'dbo'
    AND ROUTINE_TYPE = 'FUNCTION'
)
BEGIN
    DROP FUNCTION [dbo].[PadLeft];
END
GO

CREATE FUNCTION dbo.PadLeft 
(
    @OrigString VARCHAR(MAX) = NULL,
    @PadLength INT = 0,
    @PadChar CHAR(1) = ''
)
RETURNS VARCHAR(MAX)
AS
BEGIN
/* =============================================
Author:         Jeremy Knight
Create date:    16 Oct 2008
Description:    
    Pads the given string (@OrigString) to the 
    given length (@PadLength) using the given 
    character (@PadChar). Characters are added 
    to the left of given string.

NOTE: 
    VARCHAR(MAX) makes this function usable 
    in more situations but causes a requirement of
    SQL 2005 or above.
============================================= */

    -- Declare the variables
    DECLARE @Result VARCHAR(MAX); -- return variable
    DECLARE @OrigLength INT;

    -- Add the T-SQL statements to compute the return value here
    SET @OrigLength = LEN(@OrigString);
    
    IF (@OrigLength >= @PadLength)
    BEGIN
        SET @Result = @OrigString
    END
    ELSE
    BEGIN
        SET @Result = REPLICATE(@PadChar, @PadLength - @OrigLength) + @OrigString;
    END

    -- Return the result of the function
    RETURN @Result
END
GO