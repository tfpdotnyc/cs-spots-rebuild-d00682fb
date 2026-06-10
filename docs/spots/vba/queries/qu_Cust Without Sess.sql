-- Query: qu_Cust Without Sess
SELECT DISTINCTROW Customers.CustomerID, Customers.LastName, Customers.FirstName, Customers.Address, Customers.City
FROM Customers LEFT JOIN Sessions ON Customers.CustomerID = Sessions.CustomerID
WHERE (((Sessions.CustomerID) Is Null));

