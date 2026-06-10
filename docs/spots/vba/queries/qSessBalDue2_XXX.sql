-- Query: qSessBalDue2_XXX
SELECT Schools.School, qSessBalDue1.SchoolID, qSessBalDue1.LastName, qSessBalDue1.FirstName, qSessBalDue1.CustomerID, qSessBalDue1.SessionNumber, qSessBalDue1.DateTime, qSessBalDue1.TotalDue
FROM qSessBalDue1 INNER JOIN Schools ON qSessBalDue1.SchoolID = Schools.SchoolID
WHERE (((qSessBalDue1.TotalDue)>0));

