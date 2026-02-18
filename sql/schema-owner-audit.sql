SELECT
    s.name AS SchemaName,
    u.name AS SchemaOwner
FROM sys.schemas s
JOIN sys.database_principals u
    ON s.principal_id = u.principal_id
ORDER BY s.name;
