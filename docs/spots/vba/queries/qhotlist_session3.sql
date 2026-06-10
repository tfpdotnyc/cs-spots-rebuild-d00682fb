-- Query: qhotlist_session3
SELECT qhotlist_session2.SessionStatusLegendID, qhotlist_session2.Description, Customers.LastName, Customers.FirstName, Customers.CustomerID, Sessions.SessionNumber, Customers.SchoolID, qhotlist_session2.Date, qhotlist_session2.Days, qhotlist_session2.CDate, Sessions.SessionID
FROM (qhotlist_session2 INNER JOIN Sessions ON qhotlist_session2.SessionID = Sessions.SessionID) INNER JOIN Customers ON Sessions.CustomerID = Customers.CustomerID;

