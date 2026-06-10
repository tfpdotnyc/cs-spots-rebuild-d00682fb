-- Query: 000AuditSessionSelectByDate
SELECT Customers.CustomerID
FROM Customers INNER JOIN Sessions ON Customers.CustomerID = Sessions.CustomerID
WHERE (((Sessions.DateTime)>=#1/1/2000# And (Sessions.DateTime)<=#2/16/2006#))
GROUP BY Customers.CustomerID;

