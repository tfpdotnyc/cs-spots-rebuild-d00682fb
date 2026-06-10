-- Query: qpkg_by_school2_new
SELECT Customers.SchoolID, Sessions.CustomerID
FROM Sessions LEFT JOIN Customers ON Sessions.CustomerID = Customers.CustomerID
WHERE (((Sessions.CustomerID) < 99999999))
GROUP BY Customers.SchoolID, Sessions.CustomerID;

