-- Query: qMLabel_Not_Photd1
SELECT Customers.SchoolID, Customers.FirstName, Customers.LastName, Customers.Address, Customers.City, Customers.State, Customers.ZipCode, Customers.CustomerID, Customers.Phone
FROM Customers LEFT JOIN qpkg_by_school2_new ON Customers.CustomerID = qpkg_by_school2_new.CustomerID
WHERE (((Customers.CustomerID)<99999999) AND ((qpkg_by_school2_new.CustomerID) Is Null));

