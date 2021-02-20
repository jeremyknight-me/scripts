declare @start_date date = '2017-01-01';
declare @end_date date = '2017-12-31';

WITH CTE AS
(
    SELECT @start_date AS cte_start_date
    UNION ALL
    SELECT DATEADD(MONTH, 1, cte_start_date)
    FROM CTE
    WHERE DATEADD(MONTH, 1, cte_start_date) <= @end_date   
)
SELECT * 
FROM CTE