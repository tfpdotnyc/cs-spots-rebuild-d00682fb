-- Query: q_SessionOverviewOld
PARAMETERS pCustomerID IEEEDouble;
SELECT DISTINCTROW Sessions.SessionNumber AS SessionNumber, Format([Sessions].[DateTime],"mm/dd/yy") AS [Date], First(SessionItems.Description) AS SessionType, [Users].[FirstName]+' '+[Users].[LastName] AS SessionBy, [Photographers].[FirstName]+' '+[Photographers].[LastName] AS Photographer, Format([Sessions].[TotalDue],'Currency') AS Due, Last(IIf([Sessions].[YBO]=True,[SessionStatusLegend].[Description] & "-YBO- " & [Sessions].[YBO_Date],[SessionStatusLegend].[Description])) AS Status, Sessions.TotalDue, Sessions.SessionID, Studios.Name AS SessionLocation, Sessions.Roll
FROM ((Users INNER JOIN ((Photographers INNER JOIN Sessions ON Photographers.PhotographerID = Sessions.PhotographerID) LEFT JOIN (SessionItems RIGHT JOIN SessionDetail ON SessionItems.SessionItemID = SessionDetail.SessionItemID) ON Sessions.SessionID = SessionDetail.SessionID) ON Users.UserID = Sessions.UserID) LEFT JOIN (SessionStatusLegend RIGHT JOIN SessionStatus ON SessionStatusLegend.SessionStatusLegendID = SessionStatus.SessionStatusLegendID) ON Sessions.SessionID = SessionStatus.SessionID) INNER JOIN Studios ON Sessions.Studio = Studios.Studio
WHERE (((Sessions.CustomerID)=[pCustomerID]))
GROUP BY Sessions.SessionNumber, [Users].[FirstName]+' '+[Users].[LastName], [Photographers].[FirstName]+' '+[Photographers].[LastName], Sessions.TotalDue, Sessions.SessionID, Studios.Name, Sessions.Roll, Sessions.DateTime
ORDER BY Sessions.SessionNumber;

