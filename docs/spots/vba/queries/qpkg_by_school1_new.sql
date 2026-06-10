-- Query: qpkg_by_school1_new
SELECT Customers.SchoolID, Count(Customers.CustomerID) AS [# SENIORS]
FROM Customers
GROUP BY Customers.SchoolID;

