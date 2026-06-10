-- Query: qOrderTotalDeposits
SELECT DepositPayments.OrderID, Sum(DepositPayments.Amount) AS TotalDeposits
FROM DepositPayments
GROUP BY DepositPayments.OrderID;

