-- Query: 000PPOrderInfo
SELECT Orders.CustomerID, Orders.OrderNumber, Orders.OrderDate, Orders.UserID, Orders.OrderTotal AS BalDue, OrderDetails.Units, OrderItems.UnitPrice, [Units]*[UnitPrice] AS TotalCharges, OrderItems.Taxable, OrderDetails.Discount, OrderDetails.LineTotal, IIf([Taxable]=True,Round([LineTotal]*[SalesTaxRate],2),0) AS Tax, Round([Units]*[UnitPrice]*[Discount],2) AS DiscountAmt
FROM (Orders INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) INNER JOIN OrderItems ON OrderDetails.OrderItemID = OrderItems.OrderItemID;

