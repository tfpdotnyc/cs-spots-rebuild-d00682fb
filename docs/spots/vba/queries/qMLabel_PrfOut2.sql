-- Query: qMLabel_PrfOut2
SELECT DISTINCT Schools.School, qMLabel_PrfOut1.FirstName, qMLabel_PrfOut1.LastName, qMLabel_PrfOut1.CustomerID, qMLabel_PrfOut1.Address, qMLabel_PrfOut1.City, qMLabel_PrfOut1.State, qMLabel_PrfOut1.ZipCode, Format([ProofsDateOut],'mm/dd/yy') AS EffDate, qMLabel_PrfOut1.Phone, qMLabel_PrfOut1.EMail, qMLabel_PrfOut1.SchoolID
FROM qMLabel_PrfOut1 INNER JOIN Schools ON qMLabel_PrfOut1.SchoolID = Schools.SchoolID
ORDER BY Schools.School, qMLabel_PrfOut1.LastName;

