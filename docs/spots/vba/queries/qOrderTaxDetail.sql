-- Query: qOrderTaxDetail
SELECT OrderDetails.OrderID, OrderDetails.Units, OrderDetails.UnitCost, Orders.SalesTaxRate, OrderItems.Taxable, IIf([Taxable]=True,Round([Units]*[UnitCost]*[SalesTaxRate],2),0) AS Tax
FROM (Orders INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) INNER JOIN OrderItems ON OrderDetails.OrderItemID = OrderItems.OrderItemID;

