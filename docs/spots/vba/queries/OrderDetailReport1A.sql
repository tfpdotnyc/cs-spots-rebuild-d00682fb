-- Query: OrderDetailReport1A
SELECT OrderDetailReport1.OrderDate, OrderDetailReport1.CustomerID, OrderDetailReport1.OrderID, OrderDetailReport1.SalesTaxRate, OrderDetailReport1.SubTotal, OrderDetailReport1.Shipping, OrderDetailReport1.Total, OrderDetailReport1.School, OrderDetailReport1.LastName, OrderDetailReport1.FirstName, OrderDetailReport1.Deposit, Sum(OrderPayments.Amount) AS Payments
FROM OrderPayments INNER JOIN OrderDetailReport1 ON OrderPayments.OrderID = OrderDetailReport1.OrderID
GROUP BY OrderDetailReport1.OrderDate, OrderDetailReport1.CustomerID, OrderDetailReport1.OrderID, OrderDetailReport1.SalesTaxRate, OrderDetailReport1.SubTotal, OrderDetailReport1.Shipping, OrderDetailReport1.Total, OrderDetailReport1.School, OrderDetailReport1.LastName, OrderDetailReport1.FirstName, OrderDetailReport1.Deposit;

