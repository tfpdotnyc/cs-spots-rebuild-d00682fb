-- Query: AccountsReceivable_DepositsJKB
SELECT DepositPayments.CustomerID, Sum(DepositPayments.Amount) AS TotalDeposits
FROM DepositPayments
GROUP BY DepositPayments.CustomerID;

