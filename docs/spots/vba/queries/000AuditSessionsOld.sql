-- Query: 000AuditSessionsOld
SELECT Customers.CustomerID, Customers.LastName, Customers.FirstName, Customers.Gender, Customers.Address, Customers.City, Customers.State, Customers.ZipCode, Customers.Phone, Customers.StudentID, Customers.SchoolID, Customers.WebPassword, Sessions.SessionNumber, Sessions.SessionID, Sessions.DateTime, Sessions.TotalDue, Sessions.Payments, Sessions.SalesTaxRate, SessionPayments.Date, SessionPayments.Method, SessionPayments.Amount
FROM (Customers INNER JOIN Sessions ON Customers.CustomerID = Sessions.CustomerID) INNER JOIN SessionPayments ON Sessions.SessionID = SessionPayments.SessionID
ORDER BY Customers.CustomerID, Sessions.SessionID;

