-- Query: OrderDetailReport2
SELECT OrderDetailReport1A.OrderDate, OrderDetailReport1A.CustomerID, OrderDetailReport1A.OrderID, OrderDetailReport1A.SalesTaxRate, OrderDetailReport1A.SubTotal, OrderDetailReport1A.Shipping, CCur(OrderDetailReport1A.Total) AS Total, OrderDetailReport1A.School, OrderDetailReport1A.LastName, OrderDetailReport1A.FirstName, OrderDetailReport1A.Deposit, OrderDetailReport1A.Payments
FROM OrderDetailReport1A;

