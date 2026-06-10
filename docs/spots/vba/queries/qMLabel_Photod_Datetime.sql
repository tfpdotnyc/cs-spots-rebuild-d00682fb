-- Query: qMLabel_Photod_Datetime
SELECT qpkg_by_datetime.DateTime, Schools.School, Customers.FirstName, Customers.LastName, Customers.Address, Customers.City, Customers.State, Customers.ZipCode, Customers.Phone, qpkg_by_datetime.CustomerID, Customers.SchoolID, Schools.YBJobNumber
FROM (Customers INNER JOIN qpkg_by_datetime ON Customers.CustomerID = qpkg_by_datetime.CustomerID) INNER JOIN Schools ON Customers.SchoolID = Schools.SchoolID;

