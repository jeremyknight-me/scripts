IF OBJECT_ID('NumberList', 'U') IS NOT NULL
BEGIN
    DROP TABLE [dbo].NumberList
END
GO

CREATE TABLE dbo.NumberList ([Number] INT NOT NULL);

/* --- pure loop ------------- */

--DECLARE @i INT;
--SELECT @i = 1;
--SET NOCOUNT ON
--WHILE @i <= 100000
--BEGIN
--    INSERT INTO dbo.NumberList(Number) VALUES (@i);
--    SELECT @i = @i + 1;
--END;
--SET NOCOUNT OFF

/* --- quicker w/ cte ---------------- */

WITH
  Pass0 as (select 1 as C union all select 1), --2 rows
  Pass1 as (select 1 as C from Pass0 as A, Pass0 as B),--4 rows
  Pass2 as (select 1 as C from Pass1 as A, Pass1 as B),--16 rows
  Pass3 as (select 1 as C from Pass2 as A, Pass2 as B),--256 rows
  Pass4 as (select 1 as C from Pass3 as A, Pass3 as B),--65536 rows
  Pass5 as (select 1 as C from Pass4 as A, Pass4 as B), 
  Tally as (select row_number() over(order by C) as Number from Pass5)
INSERT dbo.NumberList ([Number])
SELECT [Number] FROM Tally WHERE [Number] <= 100000;

ALTER TABLE dbo.NumberList ADD CONSTRAINT PK_NumberList PRIMARY KEY CLUSTERED ([Number]);
