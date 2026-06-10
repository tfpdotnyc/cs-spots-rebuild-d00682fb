-- Query: qMLabel_Not_Ord1
SELECT Customers.SchoolID, Customers.FirstName, Customers.LastName, Customers.Address, Customers.City, Customers.State, Customers.ZipCode, Customers.CustomerID, Customers.Phone
FROM (Customers LEFT JOIN qpkg_by_school4_new ON Customers.CustomerID = qpkg_by_school4_new.CustomerID) INNER JOIN Sessions ON Customers.CustomerID = Sessions.CustomerID
WHERE (((qpkg_by_school4_new.CustomerID) Is Null));

