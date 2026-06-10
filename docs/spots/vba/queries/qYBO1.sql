-- Query: qYBO1
SELECT Customers.CustomerID, Customers.LastName, Customers.FirstName, Customers.Phone, Customers.Photographed, IIf([CustomerID]<10000000,Int([CustomerID]/1000)*1000,Int(Val(Mid([CustomerID],5))/1000)*1000) AS SchoolId
FROM Customers;

