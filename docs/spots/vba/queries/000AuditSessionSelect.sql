-- Query: 000AuditSessionSelect
SELECT Customers.CustomerID, Customers.LastName, Customers.FirstName, Customers.Gender, Customers.Address, Customers.City, Customers.State, Customers.ZipCode, Customers.Phone, Customers.StudentID, Customers.SchoolID, Customers.WebPassword, Sessions.SessionNumber, Sessions.SessionID, Sessions.DateTime, Sessions.TotalDue, Sessions.Payments, Sessions.SalesTaxRate, SessionDetail.SessionItemID, SessionItems.Description
FROM ((Customers INNER JOIN Sessions ON Customers.CustomerID = Sessions.CustomerID) INNER JOIN SessionDetail ON Sessions.SessionID = SessionDetail.SessionID) INNER JOIN SessionItems ON SessionDetail.SessionItemID = SessionItems.SessionItemID
GROUP BY Customers.CustomerID, Customers.LastName, Customers.FirstName, Customers.Gender, Customers.Address, Customers.City, Customers.State, Customers.ZipCode, Customers.Phone, Customers.StudentID, Customers.SchoolID, Customers.WebPassword, Sessions.SessionNumber, Sessions.SessionID, Sessions.DateTime, Sessions.TotalDue, Sessions.Payments, Sessions.SalesTaxRate, SessionDetail.SessionItemID, SessionItems.Description
ORDER BY Customers.CustomerID, Sessions.SessionID;

