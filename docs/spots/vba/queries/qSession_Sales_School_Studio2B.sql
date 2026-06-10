-- Query: qSession_Sales_School_Studio2B
SELECT Sessions.Studio, Count(SessionDetail.SessionDetailID) AS Total
FROM (Sessions INNER JOIN SessionDetail ON Sessions.SessionID = SessionDetail.SessionID) INNER JOIN SessionItems ON SessionDetail.SessionItemID = SessionItems.SessionItemID
GROUP BY Sessions.Studio;

