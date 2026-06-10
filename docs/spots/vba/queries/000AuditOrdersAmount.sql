-- Query: 000AuditOrdersAmount
SELECT Customers.CustomerID, Orders.OrderID, Orders.OrderNumber, Orders.OrderDate, Orders.UserID, Avg(Orders.OrderTotal) AS OrderTotal, Sum(Orders.Payments) AS Payments, Sum(OrderDetails.LineTotal) AS TotalOrder, Sum(IIf([Taxable]=True,[LineTotal]*[SalesTaxRate],0)) AS SalesTax
FROM ((Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID) INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) INNER JOIN OrderItems ON OrderDetails.OrderItemID = OrderItems.OrderItemID
GROUP BY Customers.CustomerID, Orders.OrderID, Orders.OrderNumber, Orders.OrderDate, Orders.UserID
ORDER BY Customers.CustomerID;

