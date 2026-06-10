-- Query: 000AuditOrdersPayments
SELECT Customers.CustomerID, Orders.OrderID, Orders.OrderNumber, OrderPayments.Date, OrderPayments.Method, OrderPayments.Amount
FROM Customers INNER JOIN (OrderPayments INNER JOIN Orders ON OrderPayments.OrderID = Orders.OrderID) ON Customers.CustomerID = Orders.CustomerID;

