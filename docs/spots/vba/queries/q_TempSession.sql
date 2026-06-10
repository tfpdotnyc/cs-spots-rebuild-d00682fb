-- Query: q_TempSession
SELECT Sessions.SessionNumber, Sessions.DateTime, SessionItems.Description, Users.LastName, Photographers.LastName, Sessions.TotalDue, SessionStatusLegend.Description
FROM (((((Sessions INNER JOIN SessionDetail ON Sessions.SessionID = SessionDetail.SessionID) INNER JOIN SessionItems ON SessionDetail.SessionItemID = SessionItems.SessionItemID) INNER JOIN Users ON Sessions.UserID = Users.UserID) INNER JOIN Photographers ON Sessions.PhotographerID = Photographers.PhotographerID) INNER JOIN SessionStatus ON (Sessions.CustomerID = SessionStatus.CustomerID) AND (Sessions.SessionNumber = SessionStatus.SessionNumber)) INNER JOIN SessionStatusLegend ON SessionStatus.SessionStatusLegendID = SessionStatusLegend.SessionStatusLegendID;

