USE YourDatabaseNameHere
GO
DBCC SHRINKFILE(YourDatabaseNameHere_LOG, 1)
BACKUP LOG YourDatabaseNameHere WITH TRUNCATE_ONLY
DBCC SHRINKFILE(YourDatabaseNameHere_LOG, 1)
