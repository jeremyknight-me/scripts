/* NOTE: SQL Server 2016 and above can use 'STRING_SPLIT()' */
IF EXISTS (
    SELECT * FROM dbo.sysobjects 
    WHERE 
        id = object_id(N'[dbo].[SplitString]') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
BEGIN
    DROP FUNCTION [dbo].[SplitString];
END
GO

CREATE FUNCTION dbo.SplitString ( @stringToSplit VARCHAR(MAX) )
RETURNS
    @returnList TABLE ([Name] [nvarchar] (500))
AS
BEGIN
    DECLARE @name NVARCHAR(255)
    DECLARE @pos INT

    WHILE CHARINDEX(',', @stringToSplit) > 0
    BEGIN
    SELECT @pos  = CHARINDEX(',', @stringToSplit)  
    SELECT @name = SUBSTRING(@stringToSplit, 1, @pos-1)

    INSERT INTO @returnList 
    SELECT @name

    SELECT @stringToSplit = SUBSTRING(@stringToSplit, @pos+1, LEN(@stringToSplit)-@pos)
    END

    INSERT INTO @returnList
    SELECT @stringToSplit

    RETURN
END