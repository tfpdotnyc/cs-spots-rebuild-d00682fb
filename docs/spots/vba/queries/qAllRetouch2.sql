-- Query: qAllRetouch2
SELECT qAllRetouch1.Name, qAllRetouch1.OrderNo, qAllRetouch1.LastName, qAllRetouch1.FirstName, Schools.School, qAllRetouch1.OrderDate, qAllRetouch1.Date, qAllRetouch1.Negatives, qAllRetouch1.Update
FROM qAllRetouch1 INNER JOIN Schools ON qAllRetouch1.SchoolID = Schools.SchoolID
ORDER BY qAllRetouch1.Name, qAllRetouch1.Date;

