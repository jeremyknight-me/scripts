<Query Kind="Statements">
  <Connection>
    <ID>b3111fea-7633-46e6-ad23-3e0f56d57dbc</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WideWorldImporters</Database>
    <ShowServer>true</ShowServer>
  </Connection>
</Query>

var blackItems =
	from si in StockItems
	where si.ColorID == 3 // black
	select si;
var redItems =
	from si in StockItems
	where si.ColorID == 28 // red
	select si;
blackItems
	.Union(redItems)
	.Dump();
