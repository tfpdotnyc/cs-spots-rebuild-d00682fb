-- Query: qList_Photod
SELECT Schools.School, Customers.FirstName, Customers.LastName, qpkg_by_school2_new.CustomerID, Customers.Address, Customers.City, Customers.State, Customers.ZipCode, Sessions.SessionNumber, Format([DateTime],'mm/dd/yy') AS EffDate, Customers.Phone, Customers.SchoolID
FROM ((qpkg_by_school2_new INNER JOIN Customers ON qpkg_by_school2_new.CustomerID = Customers.CustomerID) INNER JOIN Schools ON qpkg_by_school2_new.SchoolID = Schools.SchoolID) INNER JOIN Sessions ON Customers.CustomerID = Sessions.CustomerID
ORDER BY Schools.School, Customers.LastName, Sessions.SessionNumber;

