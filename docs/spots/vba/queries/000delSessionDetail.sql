-- Query: 000delSessionDetail
DELETE SessionDetail.*
FROM 000delCust INNER JOIN (Sessions INNER JOIN SessionDetail ON Sessions.SessionID = SessionDetail.SessionID) ON [000delCust].CustomerID = Sessions.CustomerID;

