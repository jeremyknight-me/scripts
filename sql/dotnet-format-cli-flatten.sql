-- Place the results from 'dotnet format --verify-no-changes --severity error --report errors.json' here.
DECLARE @json NVARCHAR(MAX) = '';

-- The redundant part of the file path that can be removed for reporting. 
-- This is usually the `src` or `source` folder in a repository.
DECLARE @remove NVARCHAR(MAX) = '';

SELECT
    -- e.DocumentId,
    -- e.ProjectId,
    -- e.[FileName],
    REPLACE(e.FilePath, @remove, '') as RelativePath,
    fc.*
FROM 
    OPENJSON(@json, N'$')
        WITH (
            DocumentId UNIQUEIDENTIFIER N'$.DocumentId.Id',
            ProjectId UNIQUEIDENTIFIER N'$.DocumentId.ProjectId.Id',
            [FileName] NVARCHAR(MAX) N'$.FileName',
            FilePath NVARCHAR(MAX) N'$.FilePath',
            FileChanges NVARCHAR(MAX) N'$.FileChanges' as JSON
        ) e
    CROSS APPLY OPENJSON(e.FileChanges, N'$')
        WITH (
            LineNumber INT N'$.LineNumber',
            CharNumber INT N'$.CharNumber',
            DiagnosticId NVARCHAR(MAX) N'$.DiagnosticId',
            FormatDescription NVARCHAR(MAX) N'$.FormatDescription'
        ) fc
ORDER BY e.FilePath, fc.LineNumber, fc.CharNumber;
