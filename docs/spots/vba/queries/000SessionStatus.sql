-- Query: 000SessionStatus
SELECT SessionStatus.SessionStatusID, SessionStatus.SessionID, SessionStatus.Date, SessionStatus.SessionStatusLegendID, SessionStatus.ItemCount, SessionStatus.UserID, SessionStatus.Studio, SessionStatus.Update, SessionStatus.Partial
FROM SessionStatus
ORDER BY SessionStatus.SessionID, SessionStatus.Date, SessionStatus.SessionStatusLegendID;

