-- Query: Pose Count By Sales Person
SELECT [FirstName]+' '+[LastName] AS Name, Count(PoseOrders.CustomerID) AS CountOfCustomerID, Orders.OrderDate
FROM Users INNER JOIN (Orders INNER JOIN PoseOrders ON Orders.CustomerID = PoseOrders.CustomerID) ON Users.UserID = Orders.UserID
WHERE (((PoseOrders.OrderNumber)<>'YB' Or (PoseOrders.OrderNumber)=''))
GROUP BY [FirstName]+' '+[LastName], Orders.OrderDate, Orders.CustomerID;

