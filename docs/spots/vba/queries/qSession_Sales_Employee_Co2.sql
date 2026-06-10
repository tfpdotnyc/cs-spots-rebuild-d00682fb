-- Query: qSession_Sales_Employee_Co2
SELECT Sessions.UserID, Users.FirstName, Count(SessionDetail.SessionDetailID) AS Total
FROM ((Sessions INNER JOIN SessionDetail ON Sessions.SessionID = SessionDetail.SessionID) INNER JOIN Users ON Sessions.UserID = Users.UserID) INNER JOIN SessionItems ON SessionDetail.SessionItemID = SessionItems.SessionItemID
GROUP BY Sessions.UserID, Users.FirstName;

