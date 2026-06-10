-- Query: qMLabel_Ord
SELECT Schools.School, Customers.FirstName, Customers.LastName, Customers.Address, Customers.City, Customers.State, Customers.ZipCode, Customers.CustomerID
FROM (Customers INNER JOIN qpkg_by_school4_new ON Customers.CustomerID = qpkg_by_school4_new.CustomerID) INNER JOIN Schools ON Customers.SchoolID = Schools.SchoolID;

