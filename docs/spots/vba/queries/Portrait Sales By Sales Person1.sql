-- Query: Portrait Sales By Sales Person1
SELECT Users.[FirstName]+' '+[LastName] AS Name, OrderDetails.OrderItemID, Orders.OrderDate, OrderDetails.Units
FROM (OrderDetails INNER JOIN Orders ON OrderDetails.OrderID = Orders.OrderID) INNER JOIN Users ON Orders.UserID = Users.UserID
GROUP BY Users.[FirstName]+' '+[LastName], OrderDetails.OrderItemID, Orders.OrderDate, OrderDetails.Units;

