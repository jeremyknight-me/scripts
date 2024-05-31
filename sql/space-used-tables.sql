DECLARE @spaceUsed TABLE (
    TableName sysname
    ,NumRows BIGINT
    ,ReservedSpace VARCHAR(50)
    ,DataSpace VARCHAR(50)
    ,IndexSize VARCHAR(50)
    ,UnusedSpace VARCHAR(50)
);

DECLARE @str VARCHAR(500)
SET @str =  'exec sp_spaceused ''?'''
INSERT INTO @spaceUsed 
EXEC sp_msforeachtable @command1=@str;

SELECT 
    TableName, 
    NumRows, 
    CONVERT(numeric(18,0),REPLACE(ReservedSpace,' KB','')) / 1024 as ReservedSpace_MB,
    CONVERT(numeric(18,0),REPLACE(DataSpace,' KB','')) / 1024 as DataSpace_MB,
    CONVERT(numeric(18,0),REPLACE(IndexSize,' KB','')) / 1024 as IndexSpace_MB,
    CONVERT(numeric(18,0),REPLACE(UnusedSpace,' KB','')) / 1024 as UnusedSpace_MB
FROM @spaceUsed
ORDER BY ReservedSpace_MB desc;
