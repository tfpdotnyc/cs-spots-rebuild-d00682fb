-- Query: AccountsReceivable2-1
SELECT Sum(DepositPayments.Amount) AS DP, DepositPayments.OrderID
FROM DepositPayments
GROUP BY DepositPayments.OrderID;

