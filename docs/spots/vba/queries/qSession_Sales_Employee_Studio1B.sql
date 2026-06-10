-- Query: qSession_Sales_Employee_Studio1B
SELECT Sessions.Studio, Studios.Name, SessionDetail.SessionItemID, SessionItems.Description, Count(SessionDetail.SessionDetailID) AS CountOfSessionDetailID
FROM (((Sessions INNER JOIN SessionDetail ON Sessions.SessionID = SessionDetail.SessionID) INNER JOIN SessionItems ON SessionDetail.SessionItemID = SessionItems.SessionItemID) INNER JOIN Users ON Sessions.UserID = Users.UserID) INNER JOIN Studios ON Sessions.Studio = Studios.Studio
GROUP BY Sessions.Studio, Studios.Name, SessionDetail.SessionItemID, SessionItems.Description;

