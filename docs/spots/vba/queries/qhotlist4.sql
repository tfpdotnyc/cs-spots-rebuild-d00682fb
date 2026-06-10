-- Query: qhotlist4
SELECT qhotlist3.Action, qhotlist3.Description, qhotlist3.LastName, qhotlist3.FirstName, qhotlist3.CustomerID, qhotlist3.OrderNumber, qhotlist3.OrderID, Schools.School, qhotlist3.Date, qhotlist3.Days, qhotlist3.CDate
FROM qhotlist3 INNER JOIN Schools ON qhotlist3.SchoolID = Schools.SchoolID
ORDER BY qhotlist3.Description, qhotlist3.LastName, qhotlist3.FirstName;

