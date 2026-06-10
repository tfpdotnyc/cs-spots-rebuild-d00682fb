-- Query: qShelfReport2
SELECT Customers.CustomerID, Customers.LastName, Customers.FirstName, Customers.Phone, Customers.EMail, qShelfReport1.OrderID, qShelfReport1.OrderNumber, qShelfReport1.Studio, Studios.Name, qShelfReport1.OrderTotal, qShelfReport1.CustomerID, Actions.Date
FROM Actions RIGHT JOIN ((Customers RIGHT JOIN qShelfReport1 ON Customers.CustomerID = qShelfReport1.CustomerID) LEFT JOIN Studios ON qShelfReport1.Studio = Studios.Studio) ON Actions.OrderID = qShelfReport1.OrderID
WHERE (((Actions.Action)=[qShelfReport1].[MaxOfAction]));

