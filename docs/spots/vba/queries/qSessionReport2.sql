-- Query: qSessionReport2
SELECT Schools.School, qSessionReport1.*
FROM qSessionReport1 INNER JOIN Schools ON qSessionReport1.Customers.SchoolID = Schools.SchoolID;

