-- Query: OrderDetailReport1
SELECT OrderDetailReport.OrderDate, OrderDetailReport.CustomerID, OrderDetailReport.OrderID, OrderDetailReport.SalesTaxRate, OrderDetailReport.SubTotal, OrderDetailReport.Shipping, OrderDetailReport.Total, OrderDetailReport.School, OrderDetailReport.LastName, OrderDetailReport.FirstName, Sum(IIf(IsNull([Amount]),0,[amount])) AS Deposit
FROM OrderDetailReport LEFT JOIN DepositPayments ON OrderDetailReport.OrderID = DepositPayments.OrderID
GROUP BY OrderDetailReport.OrderDate, OrderDetailReport.CustomerID, OrderDetailReport.OrderID, OrderDetailReport.SalesTaxRate, OrderDetailReport.SubTotal, OrderDetailReport.Shipping, OrderDetailReport.Total, OrderDetailReport.School, OrderDetailReport.LastName, OrderDetailReport.FirstName;

