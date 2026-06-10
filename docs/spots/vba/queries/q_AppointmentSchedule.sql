-- Query: q_AppointmentSchedule
PARAMETERS pStartDate DateTime, pEndDate DateTime, pStudio IEEEDouble;
SELECT Appointments.CustomerID, Trim(Customers.LastName) + ', ' + Customers.FirstName AS Customer, Customers.Phone, Appointments.AppointmentDate
FROM Appointments INNER JOIN Customers ON Appointments.CustomerID = Customers.CustomerID
WHERE ((Appointments.AppointmentDate >= pStartDate) AND (Appointments.AppointmentDate <= pEndDate) AND
(Appointments.Studio = pStudio))
ORDER BY Appointments.AppointmentDate;

