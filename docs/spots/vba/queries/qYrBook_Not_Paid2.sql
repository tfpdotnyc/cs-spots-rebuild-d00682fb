-- Query: qYrBook_Not_Paid2
SELECT Schools.School, qYrBook_Not_Paid1.LastName, qYrBook_Not_Paid1.FirstName, qYrBook_Not_Paid1.CustomerID, qYrBook_Not_Paid1.SessionID, qYrBook_Not_Paid1.SessionNumber, qYrBook_Not_Paid1.EffDate, qYrBook_Not_Paid1.YearbookFee
FROM qYrBook_Not_Paid1 INNER JOIN Schools ON qYrBook_Not_Paid1.SchoolID = Schools.SchoolID
ORDER BY Schools.School, qYrBook_Not_Paid1.LastName, qYrBook_Not_Paid1.FirstName;

