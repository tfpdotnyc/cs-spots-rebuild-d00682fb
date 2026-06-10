-- Query: qMLabel_Photod
SELECT Schools.School, Customers.FirstName, Customers.LastName, Customers.Address, Customers.City, Customers.State, Customers.ZipCode, Customers.Phone, qpkg_by_school2_new.CustomerID, Customers.SchoolID, Schools.YBJobNumber
FROM (qpkg_by_school2_new INNER JOIN Customers ON qpkg_by_school2_new.CustomerID = Customers.CustomerID) INNER JOIN Schools ON Customers.SchoolID = Schools.SchoolID;

