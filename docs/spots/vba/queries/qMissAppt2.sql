-- Query: qMissAppt2
SELECT Schools.School, qMissAppt1.CustomerID, qMissAppt1.LastName, qMissAppt1.FirstName, qMissAppt1.AppointmentDate, qMissAppt1.Name, qMissAppt1.Status, qMissAppt1.Phone
FROM qMissAppt1 INNER JOIN Schools ON qMissAppt1.SchoolID = Schools.SchoolID
ORDER BY Schools.School, qMissAppt1.LastName, qMissAppt1.FirstName;

