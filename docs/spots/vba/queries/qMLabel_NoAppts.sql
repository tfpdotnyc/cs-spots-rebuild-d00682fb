-- Query: qMLabel_NoAppts
SELECT Schools.School, Customers.FirstName, Customers.LastName, Customers.CustomerID, Customers.Address, Customers.City, Customers.State, Customers.ZipCode, Appointments.AppointmentDate AS EffDate, Customers.Phone, Customers.EMail, Customers.StudentID, Schools.YBJobNumber
FROM (Customers LEFT JOIN Appointments ON Customers.CustomerID = Appointments.CustomerID) INNER JOIN Schools ON Customers.SchoolID = Schools.SchoolID
WHERE (((Appointments.AppointmentDate) Is Null))
ORDER BY Schools.School, Customers.LastName;

