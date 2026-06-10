-- Query: eclSittingFinancailDetail_JKB
SELECT Sessions.CustomerID, SessionPayments.Method, SessionPayments.Amount
FROM Sessions INNER JOIN SessionPayments ON Sessions.SessionID = SessionPayments.SessionID
UNION ALL SELECT DepositPayments.CustomerID, DepositPayments.Method, DepositPayments.Amount
FROM DepositPayments;

