-- Query: qYearBookShootList2
SELECT qYearBookShootList2New.CustomerID, qYearBookShootList2New.LastName, qYearBookShootList2New.FirstName, qYearBookShootList2New.SessionNumber, qYearBookShootList2New.DateTime, qYearBookShootList2New.Roll, qYearBookShootList2New.MatchDate, Schools.School, qYearBookShootList2New.PoseNo, qYearBookShootList2New.OrderYB
FROM qYearBookShootList2New INNER JOIN Schools ON qYearBookShootList2New.SchoolID = Schools.SchoolID
GROUP BY qYearBookShootList2New.CustomerID, qYearBookShootList2New.LastName, qYearBookShootList2New.FirstName, qYearBookShootList2New.SessionNumber, qYearBookShootList2New.DateTime, qYearBookShootList2New.Roll, qYearBookShootList2New.MatchDate, Schools.School, qYearBookShootList2New.PoseNo, qYearBookShootList2New.OrderYB;

