SELECT  
    SERVERPROPERTY('productversion') as 'Product Version', 
    SERVERPROPERTY('productlevel') as 'Patch Level',  
    SERVERPROPERTY('edition') as 'Product Edition',
    SERVERPROPERTY('buildclrversion') as 'CLR Version',
    SERVERPROPERTY('collation') as 'Default Collation',
    SERVERPROPERTY('instancename') as 'Instance',
    SERVERPROPERTY('lcid') as 'LCID',
    SERVERPROPERTY('servername') as 'Server Name'