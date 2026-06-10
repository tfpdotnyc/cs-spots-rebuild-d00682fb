-- Query: 000AuditOrders
SELECT Customers.CustomerID, Orders.OrderID, Orders.OrderNumber, Orders.OrderDate, Orders.OrderTotal, Orders.Payments, Orders.SalesTaxRate, Orders.UserID
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CustomerID, Orders.OrderID;

