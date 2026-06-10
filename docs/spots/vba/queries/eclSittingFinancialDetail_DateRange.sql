-- Query: eclSittingFinancialDetail_DateRange
SELECT Sessions.CustomerID, SessionPayments.Method, SessionPayments.Amount, SessionPayments.Date, CustomerListData.ListID
FROM (Sessions INNER JOIN SessionPayments ON Sessions.SessionID = SessionPayments.SessionID) INNER JOIN CustomerListData ON Sessions.CustomerID = CustomerListData.CustomerID
UNION ALL SELECT DepositPayments.CustomerID, DepositPayments.Method, DepositPayments.Amount, DepositPayments.Date, CustomerListData.ListID
FROM DepositPayments INNER JOIN CustomerListData ON DepositPayments.CustomerID = CustomerListData.CustomerID;

