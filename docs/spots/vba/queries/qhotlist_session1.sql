-- Query: qhotlist_session1
SELECT SessionStatus.SessionID, Max(SessionStatus.SessionStatusLegendID) AS MaxOfSessionStatusLegendID
FROM SessionStatus
GROUP BY SessionStatus.SessionID;

