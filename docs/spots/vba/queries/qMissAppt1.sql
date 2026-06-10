-- Query: qMissAppt1
SELECT Customers.SchoolID, IIf([Customers].[CustomerID]<99999999,Int([Customers].[CustomerID]/1000)*1000,Int(Val(Mid$(Trim$(Str([Customers].[CustomerID])),5))/1000)*1000) AS SchoolIDOld, Customers.CustomerID, Customers.LastName, Customers.FirstName, Appointments.AppointmentDate, Studios.Name, Appointments.Status, Customers.Phone
FROM (Customers INNER JOIN Appointments ON Customers.CustomerID = Appointments.CustomerID) INNER JOIN Studios ON Appointments.Studio = Studios.Studio
WHERE (((Customers.CustomerID)<99999999) AND ((Appointments.Status)='M'));

