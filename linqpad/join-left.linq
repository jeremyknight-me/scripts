<Query Kind="Expression">
  <Connection>
    <ID>b3111fea-7633-46e6-ad23-3e0f56d57dbc</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WideWorldImporters</Database>
    <ShowServer>true</ShowServer>
  </Connection>
</Query>

from si in StockItems
join colors in Colors on si.ColorID equals colors.ColorID into itemColors
	from c in itemColors.DefaultIfEmpty()
select new { si, c }
