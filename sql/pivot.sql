DECLARE @data TABLE (datestamp date);
DECLARE @current date = getdate();
DECLARE @i date = DATEADD(year, -3, @current);
WHILE (@i < @current)
BEGIN
    INSERT INTO @data (datestamp) VALUES (@i);
    SET @i = DATEADD(d, 1, @i);
END;

WITH cte_data AS
(
    select YEAR(d.datestamp) Yr, MONTH(d.datestamp) Mnt, count(*) Number
    from @data d
    group by YEAR(d.datestamp), MONTH(d.datestamp)
)
SELECT *
FROM cte_data cte
PIVOT
(
    SUM(Number)
    FOR Mnt IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
) as p;

WITH cte_data AS
(
    select YEAR(d.datestamp) Yr, LEFT(DATENAME(month, d.datestamp), 3) Mnt, count(*) Number
    from @data d
    group by YEAR(d.datestamp), DATENAME(month, d.datestamp)
)
SELECT *
FROM cte_data cte
PIVOT
(
    SUM(Number)
    FOR Mnt IN ([Jan], [Feb], [Mar], [Apr], [May], [Jun], [Jul], [Aug], [Sep], [Oct], [Nov], [Dec])
) as p