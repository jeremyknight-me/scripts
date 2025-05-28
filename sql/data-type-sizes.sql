/*
NOTES:
  - Assume all types are setup at "breakpoints" and adding 1 more will add to storage sizes.
*/

DECLARE
	@ti tinyint = 1,
	@si smallint = 1,
	@i int = 1,
	@bi bigint = 1,
	@b bit = 1,
	@dm decimal = 111111111111111.1234, -- decimal(18,0)
	@dm9 decimal(9, 4) = 11111.1234,
	@dm19 decimal(19, 4) = 111111111111111.1234,
	@dm28 decimal(28, 4) = 111111111111111111111111.1234,
	@dm38 decimal(38, 4) = 1111111111111111111111111111111111.1234,
	@m money = 1.1,
	@sm smallmoney = 1.1,
	@f float = 1.1,
	@r real = 1.1,
	@d date = '2025-05-28',
	@t time = '14:43:56.1234567', -- time(7)
	@t2 time(2) = '14:43:56.12',
	@t4 time(4) = '14:43:56.1234',
	@t7 time(7) = '14:43:56.1234567',
	@dt2 datetime2 = '2025-05-28 14:43:56.1234567', -- datetime2(7)
	@dt2_2 datetime2(2) = '2025-05-28 14:43:56.1234567',
	@dt2_4 datetime2(4) = '2025-05-28 14:43:56.1234567',
	@dt2_7 datetime2(7) = '2025-05-28 14:43:56.1234567',
	@dto datetimeoffset = '2025-05-28 14:43:56.1234567',
	@dto_2 datetimeoffset(2) = '2025-05-28 14:43:56.1234567', -- datetimeoffset(7)
	@dto_4 datetimeoffset(4) = '2025-05-28 14:43:56.1234567',
	@dto_7 datetimeoffset(7) = '2025-05-28 14:43:56.1234567',
	@dt datetime = '2025-05-28 14:43:56.123',
	@sdt smalldatetime = '2025-05-28 14:43:56',
	@c char(1) = 'A',
	@nc nchar(1) = N'A',
	@vc varchar(1) = 'A',
	@nvc nvarchar(1) = N'A';

SELECT 'tinyint' as DataType, DATALENGTH(@ti) as Bytes
UNION SELECT 'smallint' as DataType, DATALENGTH(@si) as Bytes
UNION SELECT 'int' as DataType, DATALENGTH(@i) as Bytes
UNION SELECT 'bigint' as DataType, DATALENGTH(@bi) as Bytes
UNION SELECT 'bit' as DataType, DATALENGTH(@b) as Bytes
UNION SELECT 'decimal' as DataType, DATALENGTH(@dm) as Bytes
UNION SELECT 'decimal(9,4)' as DataType, DATALENGTH(@dm9) as Bytes
UNION SELECT 'decimal(19,4)' as DataType, DATALENGTH(@dm19) as Bytes
UNION SELECT 'decimal(28,4)' as DataType, DATALENGTH(@dm28) as Bytes
UNION SELECT 'decimal(38,4)' as DataType, DATALENGTH(@dm38) as Bytes
UNION SELECT 'money' as DataType, DATALENGTH(@m) as Bytes
UNION SELECT 'smallmoney' as DataType, DATALENGTH(@sm) as Bytes
UNION SELECT 'float' as DataType, DATALENGTH(@f) as Bytes
UNION SELECT 'real' as DataType, DATALENGTH(@r) as Bytes
UNION SELECT 'date' as DataType, DATALENGTH(@d) as Bytes
UNION SELECT 'time' as DataType, DATALENGTH(@t) as Bytes
UNION SELECT 'time(2)' as DataType, DATALENGTH(@t2) as Bytes
UNION SELECT 'time(4)' as DataType, DATALENGTH(@t4) as Bytes
UNION SELECT 'time(7)' as DataType, DATALENGTH(@t7) as Bytes
UNION SELECT 'datetime2' as DataType, DATALENGTH(@dt2) as Bytes
UNION SELECT 'datetime2(2)' as DataType, DATALENGTH(@dt2_2) as Bytes
UNION SELECT 'datetime2(4)' as DataType, DATALENGTH(@dt2_4) as Bytes
UNION SELECT 'datetime2(7)' as DataType, DATALENGTH(@dt2_7) as Bytes
UNION SELECT 'datetimeoffset' as DataType, DATALENGTH(@dto) as Bytes
UNION SELECT 'datetimeoffset(2)' as DataType, DATALENGTH(@dto_2) as Bytes
UNION SELECT 'datetimeoffset(4)' as DataType, DATALENGTH(@dto_4) as Bytes
UNION SELECT 'datetimeoffset(7)' as DataType, DATALENGTH(@dto_7) as Bytes
UNION SELECT 'datetime' as DataType, DATALENGTH(@dt) as Bytes
UNION SELECT 'smalldatetime' as DataType, DATALENGTH(@sdt) as Bytes
UNION SELECT 'char(1)' as DataType, DATALENGTH(@c) as Bytes
UNION SELECT 'nchar(1)' as DataType, DATALENGTH(@nc) as Bytes
UNION SELECT 'varchar(1)' as DataType, DATALENGTH(@vc) as Bytes
UNION SELECT 'nvarchar(1)' as DataType, DATALENGTH(@nvc) as Bytes;
