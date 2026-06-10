-- Query: qhotlist_session2
SELECT SessionStatus.SessionStatusLegendID, SessionStatusLegend.Description, SessionStatus.SessionID, SessionStatus.Date, SessionStatusLegend.Days, DateAdd('d',[Days],[Date]) AS CDate, Now() AS Expr1
FROM qhotlist_session1 INNER JOIN (SessionStatusLegend INNER JOIN SessionStatus ON SessionStatusLegend.SessionStatusLegendID = SessionStatus.SessionStatusLegendID) ON (qhotlist_session1.SessionID = SessionStatus.SessionID) AND (qhotlist_session1.MaxOfSessionStatusLegendID = SessionStatus.SessionStatusLegendID)
WHERE (((DateAdd('d',[Days],[Date]))<Now()));

