IF EXISTS (
    SELECT * FROM INFORMATION_SCHEMA.ROUTINES
    WHERE   ROUTINE_NAME = 'GetSqlServerInfo'
    AND ROUTINE_SCHEMA = 'dbo'
    AND ROUTINE_TYPE = 'FUNCTION'
)
BEGIN
    DROP FUNCTION [dbo].[GetSqlServerInfo];
END
GO

CREATE FUNCTION dbo.GetSqlServerInfo()
RETURNS TABLE 
AS
RETURN 
(
	SELECT  
		SERVERPROPERTY('productversion') as 'Product Version', 
		SERVERPROPERTY('productlevel') as 'Patch Level',  
		SERVERPROPERTY('edition') as 'Product Edition',
		SERVERPROPERTY('buildclrversion') as 'CLR Version',
		SERVERPROPERTY('collation') as 'Default Collation',
		SERVERPROPERTY('instancename') as 'Instance',
		SERVERPROPERTY('lcid') as 'LCID',
		SERVERPROPERTY('servername') as 'Server Name'
)
GO
