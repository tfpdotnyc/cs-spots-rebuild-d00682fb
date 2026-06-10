-- Query: 000delSessionStatus
DELETE SessionStatus.*
FROM 000delCust INNER JOIN (Sessions INNER JOIN SessionStatus ON Sessions.SessionID = SessionStatus.SessionID) ON [000delCust].CustomerID = Sessions.CustomerID;

