delete ut
from 
  dbo.YourTable ut
  left outer join dbo.YourOtherTable yot on ut.Id = yot.YourTableId
where yot.Id IS NULL;
