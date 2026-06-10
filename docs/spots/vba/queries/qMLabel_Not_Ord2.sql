-- Query: qMLabel_Not_Ord2
SELECT DISTINCT Schools.School, qMLabel_Not_Ord1.FirstName, qMLabel_Not_Ord1.LastName, qMLabel_Not_Ord1.Address, qMLabel_Not_Ord1.City, qMLabel_Not_Ord1.State, qMLabel_Not_Ord1.ZipCode, qMLabel_Not_Ord1.CustomerID, '' AS EffDate, qMLabel_Not_Ord1.Phone, qMLabel_Not_Ord1.SchoolID
FROM qMLabel_Not_Ord1 INNER JOIN Schools ON qMLabel_Not_Ord1.SchoolID = Schools.SchoolID;

