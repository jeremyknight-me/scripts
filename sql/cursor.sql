DECLARE rsCursor CURSOR LOCAL FAST_FORWARD FOR
SELECT DISTINCT Field1 FROM Table1

OPEN rsCursor;
FETCH NEXT FROM rsCursor INTO @currentField1;
WHILE (@@FETCH_STATUS = 0)
BEGIN
    -- code in loop

    FETCH NEXT FROM rsCursor INTO @currentField1;
END

CLOSE rsCursor;
DEALLOCATE rsCursor;