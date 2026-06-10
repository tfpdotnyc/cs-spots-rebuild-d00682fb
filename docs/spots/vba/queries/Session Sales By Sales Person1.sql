-- Query: Session Sales By Sales Person1
SELECT Users.[FirstName]+' '+[LastName] AS Name, SessionItems.Description, Sessions.DateTime, Count(SessionDetail.Units) AS Units
FROM ((SessionDetail INNER JOIN Sessions ON SessionDetail.SessionID = Sessions.SessionID) INNER JOIN Users ON Sessions.UserID = Users.UserID) INNER JOIN SessionItems ON SessionDetail.SessionItemID = SessionItems.SessionItemID
GROUP BY Users.[FirstName]+' '+[LastName], SessionItems.Description, Sessions.DateTime;

