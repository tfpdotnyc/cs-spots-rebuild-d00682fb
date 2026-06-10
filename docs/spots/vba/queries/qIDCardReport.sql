-- Query: qIDCardReport
SELECT Schools.School, Customers.FirstName, Customers.LastName, Customers.CustomerID, Customers.Address, Customers.City, Customers.State, Customers.ZipCode, Customers.Phone, Customers.PrintedIDs, IIf(IsNull([PrintedIDs]),0,[PrintedIDs]) AS PrintedIDs2
FROM Customers INNER JOIN Schools ON Customers.SchoolID = Schools.SchoolID;

