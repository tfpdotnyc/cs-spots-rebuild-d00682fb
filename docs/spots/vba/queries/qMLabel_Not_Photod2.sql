-- Query: qMLabel_Not_Photod2
SELECT Schools.School, qMLabel_Not_Photd1.FirstName, qMLabel_Not_Photd1.LastName, qMLabel_Not_Photd1.Address, qMLabel_Not_Photd1.City, qMLabel_Not_Photd1.State, qMLabel_Not_Photd1.ZipCode, qMLabel_Not_Photd1.CustomerID, '' AS EffDate, qMLabel_Not_Photd1.Phone, qMLabel_Not_Photd1.SchoolID, Schools.YBJobNumber
FROM qMLabel_Not_Photd1 INNER JOIN Schools ON qMLabel_Not_Photd1.SchoolID = Schools.SchoolID
ORDER BY Schools.School, qMLabel_Not_Photd1.LastName;

