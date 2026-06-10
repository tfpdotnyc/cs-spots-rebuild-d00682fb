-- Query: 000AuditSessions
SELECT Customers.CustomerID, Customers.LastName, Customers.FirstName, Customers.Gender, Customers.Address, Customers.City, Customers.State, Customers.ZipCode, Customers.Phone, Customers.StudentID, Customers.SchoolID, Customers.WebPassword, Sessions.SessionNumber, Sessions.SessionID, Sessions.DateTime, Sessions.TotalDue, Sessions.Payments, Sessions.SalesTaxRate
FROM Customers INNER JOIN Sessions ON Customers.CustomerID = Sessions.CustomerID
ORDER BY Customers.CustomerID, Sessions.SessionID;

