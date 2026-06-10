-- Query: 000AuditOrdersTotalPayments
SELECT Customers.CustomerID, Orders.OrderID, Orders.OrderNumber, Sum(OrderPayments.Amount) AS TotalOrderPayments
FROM Customers INNER JOIN (OrderPayments INNER JOIN Orders ON OrderPayments.OrderID = Orders.OrderID) ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Orders.OrderID, Orders.OrderNumber;

