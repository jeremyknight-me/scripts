<Query Kind="Statements">
  <Connection>
    <ID>b3111fea-7633-46e6-ad23-3e0f56d57dbc</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WideWorldImporters</Database>
    <ShowServer>true</ShowServer>
  </Connection>
</Query>

var query =
	from ol in OrderLines
	where ol.OrderID == 7
	select ol.StockItemID;
query
	.ToList()
	.Aggregate(
		new StringBuilder(), (a,b) => {
			if (a.Length > 0)
			{
				a.Append(",");
			}
			a.Append(b);
			return a;
		}
	)
	.Dump();