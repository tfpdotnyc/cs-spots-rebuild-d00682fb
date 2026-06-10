-- Query: AccountReceivable2
SELECT Sum(OrderPayments.Amount) AS TotalP, Orders.CustomerID, Orders.OrderNumber, Orders.OrderID
FROM OrderPayments INNER JOIN Orders ON OrderPayments.OrderID = Orders.OrderID
GROUP BY Orders.CustomerID, Orders.OrderNumber, Orders.OrderID;

