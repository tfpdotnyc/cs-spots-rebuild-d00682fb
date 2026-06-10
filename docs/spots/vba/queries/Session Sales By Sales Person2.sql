-- Query: Session Sales By Sales Person2
SELECT Users.[FirstName]+' '+[LastName] AS Name, SessionItems.Description, Sessions.DateTime, Count(SessionDetail.Units) AS Units
FROM ((SessionDetail INNER JOIN Sessions ON SessionDetail.SessionID = Sessions.SessionID) INNER JOIN Users ON Sessions.UserID = Users.UserID) INNER JOIN SessionItems ON SessionDetail.SessionItemID = SessionItems.SessionItemID
GROUP BY Users.[FirstName]+' '+[LastName], SessionItems.Description, Sessions.DateTime
UNION SELECT Users.[FirstName]+' '+[LastName] AS Name, ' TOTAL SESSIONS ' AS Expr1, Sessions.DateTime,  Count(Sessions.DateTime) AS CountOfSessionDate
FROM Sessions INNER JOIN Users ON Sessions.UserID = Users.UserID
GROUP BY Users.[FirstName]+' '+[LastName], Sessions.DateTime;

