-- Query: qhotlist_session4
SELECT qhotlist_session3.SessionStatusLegendID, qhotlist_session3.Description, qhotlist_session3.LastName, qhotlist_session3.FirstName, qhotlist_session3.CustomerID, qhotlist_session3.SessionNumber, qhotlist_session3.SessionID, qhotlist_session3.SchoolID, Schools.School, qhotlist_session3.Date, qhotlist_session3.Days, qhotlist_session3.CDate
FROM qhotlist_session3 INNER JOIN Schools ON qhotlist_session3.SchoolID = Schools.SchoolID;

