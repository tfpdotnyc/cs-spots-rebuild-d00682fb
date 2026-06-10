-- Query: qOrderDateTotalPayments
SELECT Orders.OrderDate, Sum(OrderPayments.Amount) AS TotalPaymentsBD
FROM OrderPayments INNER JOIN Orders ON OrderPayments.OrderID = Orders.OrderID
GROUP BY Orders.OrderDate;

