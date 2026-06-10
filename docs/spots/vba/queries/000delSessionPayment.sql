-- Query: 000delSessionPayment
DELETE SessionPayments.*
FROM 000delCust INNER JOIN (Sessions INNER JOIN SessionPayments ON Sessions.SessionID = SessionPayments.SessionID) ON [000delCust].CustomerID = Sessions.CustomerID;

