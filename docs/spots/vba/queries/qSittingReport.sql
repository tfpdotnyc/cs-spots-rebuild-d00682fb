-- Query: qSittingReport
SELECT Schools.School, Studios.Name, qSessionReport1.*
FROM (qSessionReport1 INNER JOIN Studios ON qSessionReport1.Studio = Studios.Studio) INNER JOIN Schools ON qSessionReport1.Customers.SchoolID = Schools.SchoolID
WHERE (((qSessionReport1.SessionNumber)='SA'));

