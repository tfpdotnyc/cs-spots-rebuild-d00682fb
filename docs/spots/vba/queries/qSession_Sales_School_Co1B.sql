-- Query: qSession_Sales_School_Co1B
SELECT SessionDetail.SessionItemID, SessionItems.Description, Count(SessionDetail.SessionDetailID) AS CountOfSessionDetailID
FROM (Sessions INNER JOIN SessionDetail ON Sessions.SessionID = SessionDetail.SessionID) INNER JOIN SessionItems ON SessionDetail.SessionItemID = SessionItems.SessionItemID
GROUP BY SessionDetail.SessionItemID, SessionItems.Description;

