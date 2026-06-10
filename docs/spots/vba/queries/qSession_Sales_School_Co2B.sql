-- Query: qSession_Sales_School_Co2B
SELECT Count(SessionDetail.SessionDetailID) AS Total
FROM (Sessions INNER JOIN SessionDetail ON Sessions.SessionID = SessionDetail.SessionID) INNER JOIN SessionItems ON SessionDetail.SessionItemID = SessionItems.SessionItemID;

