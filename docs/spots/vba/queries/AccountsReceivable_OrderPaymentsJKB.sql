-- Query: AccountsReceivable_OrderPaymentsJKB
SELECT Orders.CustomerID, Sum(OrderPayments.Amount) AS TotalOrderPayments
FROM Orders INNER JOIN OrderPayments ON Orders.OrderID = OrderPayments.OrderID
GROUP BY Orders.CustomerID;

