/*
    When possible use TRUNCATE. 
    This method is designed for when TRUNCATE is not possible
*/

DECLARE @rowsDeleted INT = 1;
WHILE (@rowsDeleted > 0)
BEGIN
    DELETE TOP(1000) -- delete X rows a time; here x = 1000
	FROM [dbo].[YourTable]
	where Id < 1000000; -- setup where clause as needed
    SET @rowsDeleted = @@ROWCOUNT;
END
