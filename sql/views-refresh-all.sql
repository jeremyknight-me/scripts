DECLARE rsViewCursor CURSOR FORWARD_ONLY READ_ONLY FOR
SELECT
    SCHEMA_NAME(v.schema_id) AS schema_name,
    v.name 
FROM sys.views v

DECLARE 
    @cursorSchema NVARCHAR(MAX),
    @cursorName NVARCHAR(MAX)

OPEN rsViewCursor;
FETCH NEXT FROM rsViewCursor INTO @cursorSchema, @cursorName;
WHILE (@@FETCH_STATUS = 0)
BEGIN
    DECLARE @viewToRefresh NVARCHAR(MAX);
    SET @viewToRefresh = LTRIM(RTRIM(@cursorSchema)) + '.' + LTRIM(RTRIM(@cursorName));

    EXECUTE SP_REFRESHVIEW @viewToRefresh;

    FETCH NEXT FROM rsViewCursor INTO @cursorSchema, @cursorName;
END

CLOSE rsViewCursor;
DEALLOCATE rsViewCursor;