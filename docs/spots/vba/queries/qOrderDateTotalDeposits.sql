-- Query: qOrderDateTotalDeposits
SELECT Orders.OrderDate, Sum(DepositPayments.Amount) AS TotalDepositsBD
FROM DepositPayments INNER JOIN Orders ON DepositPayments.OrderID = Orders.OrderID
GROUP BY Orders.OrderDate;

