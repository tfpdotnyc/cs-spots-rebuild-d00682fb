-- Query: Query13
SELECT Customers.LastName, Customers.FirstName, Appointments.AppointmentDate, Appointments.Studio
FROM Appointments INNER JOIN Customers ON Appointments.CustomerID = Customers.CustomerID
WHERE (((Appointments.Studio)=9))
ORDER BY Customers.LastName, Customers.FirstName;

