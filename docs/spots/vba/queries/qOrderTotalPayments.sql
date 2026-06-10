-- Query: qOrderTotalPayments
SELECT OrderPayments.OrderID, Sum(OrderPayments.Amount) AS TotalPayments
FROM OrderPayments
GROUP BY OrderPayments.OrderID;

