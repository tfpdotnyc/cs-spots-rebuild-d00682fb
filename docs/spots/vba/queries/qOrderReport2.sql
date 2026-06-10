-- Query: qOrderReport2
SELECT Schools.School, qOrderReport1.*
FROM qOrderReport1 INNER JOIN Schools ON qOrderReport1.Customers.SchoolID = Schools.SchoolID;

