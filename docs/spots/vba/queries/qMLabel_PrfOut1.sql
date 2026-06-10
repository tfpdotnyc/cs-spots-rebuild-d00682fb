-- Query: qMLabel_PrfOut1
SELECT Customers.SchoolID AS SchoolID, Customers.FirstName, Customers.LastName, Customers.CustomerID, Customers.Address, Customers.City, Customers.State, Customers.ZipCode, Sessions.ProofsDateOut, Customers.Phone, Customers.EMail
FROM Sessions INNER JOIN Customers ON Sessions.CustomerID = Customers.CustomerID
WHERE (((Sessions.ProofsDateOut) Is Not Null) AND ((Sessions.ProofsDateIn) Is Null));

