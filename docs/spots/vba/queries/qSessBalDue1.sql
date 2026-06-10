-- Query: qSessBalDue1
SELECT Customers.SchoolID, Customers.LastName, Customers.FirstName, Customers.CustomerID, Sessions.SessionNumber, Sessions.DateTime, Sessions.TotalDue
FROM Customers INNER JOIN Sessions ON Customers.CustomerID = Sessions.CustomerID;

