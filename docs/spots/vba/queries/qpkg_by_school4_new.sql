-- Query: qpkg_by_school4_new
SELECT Customers.SchoolID, Orders.CustomerID
FROM Orders LEFT JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.SchoolID, Orders.CustomerID;

