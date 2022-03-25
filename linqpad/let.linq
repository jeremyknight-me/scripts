<Query Kind="Expression">
  <Connection>
    <ID>96dd443e-5235-4782-8325-dd366d35b0e7</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WideWorldImporters</Database>
    <ShowServer>true</ShowServer>
  </Connection>
</Query>

from si in StockItems
let tax = (si.TaxRate/100)*si.UnitPrice
where tax > 4
select new { tax, si.TaxRate, si.UnitPrice }