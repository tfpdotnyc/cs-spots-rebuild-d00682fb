-- Query: q_RetouchStatus
PARAMETERS pSchoolID IEEEDouble;
INSERT INTO RetouchStatus ( OrderID, CustomerID, OrderDate, LastName, FirstName )
SELECT Orders.OrderID, Orders.CustomerID, Orders.OrderDate, Customers.LastName, Customers.FirstName
FROM Orders INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Orders.CustomerID >= pSchoolID AND Orders.CustomerID < (pSchoolID + 1000);

