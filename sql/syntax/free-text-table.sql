select ft.*, c.*
from 
	dbo.Customer c
	inner join freetexttable(dbo.Customer, [Name], 'some keywords here') ft on c.Id = ft.[Key]
order by ft.[rank] desc
