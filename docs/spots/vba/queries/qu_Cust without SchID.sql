-- Query: qu_Cust without SchID
SELECT DISTINCTROW Customers.CustomerID, Customers.LastName, Customers.FirstName
FROM Customers LEFT JOIN CustSchID ON Customers.CustomerID = CustSchID.CustomerID
WHERE (((Customers.CustomerID) Not Like "1996*") AND ((CustSchID.CustomerID) Is Null));

