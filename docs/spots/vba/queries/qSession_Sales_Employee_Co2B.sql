-- Query: qSession_Sales_Employee_Co2B
SELECT Count(SessionDetail.SessionDetailID) AS Total
FROM ((Sessions INNER JOIN SessionDetail ON Sessions.SessionID = SessionDetail.SessionID) INNER JOIN Users ON Sessions.UserID = Users.UserID) INNER JOIN SessionItems ON SessionDetail.SessionItemID = SessionItems.SessionItemID;

