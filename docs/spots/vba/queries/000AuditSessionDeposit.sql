-- Query: 000AuditSessionDeposit
SELECT DepositPayments.CustomerID, DepositPayments.SessionID, Sum(DepositPayments.Amount) AS TotalDeposit
FROM DepositPayments
WHERE (((DepositPayments.OrderID) = 0))
GROUP BY DepositPayments.CustomerID, DepositPayments.SessionID;

