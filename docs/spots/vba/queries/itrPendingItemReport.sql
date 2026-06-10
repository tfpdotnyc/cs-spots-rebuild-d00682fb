-- Query: itrPendingItemReport
SELECT Customers.CustomerID, Customers.LastName, Customers.FirstName, Orders.OrderNumber, Orders.OrderDate, itrLatestAction.PendingItem, itrLatestAction.Date, itrLatestAction.Action, Schools.School
FROM ((Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID) LEFT JOIN Schools ON Customers.SchoolID = Schools.SchoolID) INNER JOIN itrLatestAction ON Orders.OrderID = itrLatestAction.OrderID
WHERE (((itrLatestAction.Action)=17));

