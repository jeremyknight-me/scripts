-- Prior to SQL Server 2012, this is what typical T-SQL to compute last day of the month would look like:
DECLARE @date DATE = '2017-12-15'; 
DECLARE @firstOfMonth DATE = DATEFROMPARTS(YEAR(@date), MONTH(@date), 1); 
SELECT DATEADD(DAY,-1, DATEADD(MONTH, 1, @firstOfMonth));

-- With SQL Server 2012 or later, the EOMONTH() gives you a much more concise option which looks like:
DECLARE @date DATE = '2017-12-15';
SELECT EOMONTH(@date)