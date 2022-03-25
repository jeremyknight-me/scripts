<Query Kind="Statements">
  <Connection>
    <ID>b3111fea-7633-46e6-ad23-3e0f56d57dbc</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WideWorldImporters</Database>
    <ShowServer>true</ShowServer>
  </Connection>
</Query>

var invoiceItems =
	from si in StockItems
	join il in InvoiceLines on si.StockItemID equals il.StockItemID
	select si;
var orderItems = 
	from si in StockItems
	join ol in OrderLines on si.StockItemID equals ol.StockItemID
	select si;
invoiceItems
	.Intersect(orderItems)
	.Distinct()
	.OrderBy(x => x.StockItemName)
	.Dump();