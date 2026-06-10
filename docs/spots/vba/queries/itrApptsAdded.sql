-- Query: itrApptsAdded
SELECT Appointments.CustomerID, Appointments.AppointmentDate, Appointments.ScheduledOn, Appointments.SessionType, Customers.FirstName, Customers.LastName, Customers.SchoolID, Schools.School, Appointments.ScheduledBy, Users.LastName AS SchedbyLN, Users.FirstName AS SchedbyFN, Appointments.Studio, Studios.Name, Appointments.Status, 1 AS [Count]
FROM (((Appointments LEFT JOIN Customers ON Appointments.CustomerID = Customers.CustomerID) LEFT JOIN Schools ON Customers.SchoolID = Schools.SchoolID) LEFT JOIN Users ON Appointments.ScheduledBy = Users.UserID) LEFT JOIN Studios ON Appointments.Studio = Studios.Studio;

