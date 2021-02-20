IF EXISTS (
    SELECT * FROM dbo.sysobjects 
    WHERE id = object_id(N'[dbo].[fPadRight]') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
BEGIN
    DROP FUNCTION [dbo].[fPadRight];
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fPadRight 
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
    to the right of given string.

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
        SET @Result =  @OrigString + REPLICATE(@PadChar, @PadLength - @OrigLength);
    END

    -- Return the result of the function
    RETURN @Result
END
GO