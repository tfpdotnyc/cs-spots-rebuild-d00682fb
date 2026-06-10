-- Query: q_SessionStatusOverview
PARAMETERS pSessionID IEEEDouble;
SELECT SessionStatus.ItemCount, IIf([Sessions].[YBO]=True,IIf([SessionStatus].[Partial]=True,[SessionStatusLegend].[Description] & "-YBO- " & [Sessions].[YBO_Date] & "-Part",[SessionStatusLegend].[Description] & "-YBO- " & [Sessions].[YBO_Date]),IIf([SessionStatus].[Partial]=True,[SessionStatusLegend].[Description] & "-Part",[SessionStatusLegend].[Description])) AS Status, SessionStatus.Date, Trim(Users.FirstName)+' '+Users.LastName AS ProcessedBy, Studios.Name AS Location
FROM ((Studios INNER JOIN (Users INNER JOIN SessionStatus ON Users.UserID = SessionStatus.UserID) ON Studios.Studio = SessionStatus.Studio) INNER JOIN SessionStatusLegend ON (SessionStatus.SessionStatusLegendID = SessionStatusLegend.SessionStatusLegendID) AND (SessionStatus.SessionStatusLegendID = SessionStatusLegend.SessionStatusLegendID)) INNER JOIN Sessions ON SessionStatus.SessionID = Sessions.SessionID
WHERE (((SessionStatus.SessionID)=[pSessionID]))
ORDER BY SessionStatus.Date;

