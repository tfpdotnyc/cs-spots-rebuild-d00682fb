-- Query: AccountReceivable2JKB
SELECT Sum(OrderPayments.Amount+DepositPayments.Amount) AS TotalPaid, DepositPayments.CustomerID
FROM OrderPayments, DepositPayments
GROUP BY DepositPayments.CustomerID;

