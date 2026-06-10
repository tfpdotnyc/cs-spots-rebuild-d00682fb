-- Query: qList_Ord
SELECT Schools.School, Customers.FirstName, Customers.LastName, qpkg_by_school4_new.CustomerID, Customers.Address, Customers.City, Customers.State, Customers.ZipCode, Orders.OrderNumber, Format([OrderDate],'mm/dd/yy') AS EffDate, Customers.Phone, Customers.SchoolID
FROM ((Customers INNER JOIN qpkg_by_school4_new ON Customers.CustomerID = qpkg_by_school4_new.CustomerID) INNER JOIN Schools ON qpkg_by_school4_new.SchoolID = Schools.SchoolID) INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Schools.School, Customers.LastName, Orders.OrderNumber;

