-- Query: qSession_Sales_Employee_Studio2B
SELECT Sessions.Studio, Count(SessionDetail.SessionDetailID) AS Total
FROM (((Sessions INNER JOIN SessionDetail ON Sessions.SessionID = SessionDetail.SessionID) INNER JOIN SessionItems ON SessionDetail.SessionItemID = SessionItems.SessionItemID) INNER JOIN Users ON Sessions.UserID = Users.UserID) INNER JOIN Studios ON Sessions.Studio = Studios.Studio
GROUP BY Sessions.Studio;

