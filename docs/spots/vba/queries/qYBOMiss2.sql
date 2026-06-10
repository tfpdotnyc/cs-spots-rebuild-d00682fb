-- Query: qYBOMiss2
SELECT qYBOMiss1.CustomerID, qYBOMiss1.LastName, qYBOMiss1.FirstName, qYBOMiss1.Phone, qYBOMiss1.Photographed, qYBOMiss1.SchoolId, qYBOMiss1.YBO, qYBOMiss1.SessionNumber, Schools.School, Schools.SchoolPath
FROM qYBOMiss1 INNER JOIN Schools ON qYBOMiss1.SchoolId = Schools.SchoolID;

