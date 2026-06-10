-- Query: Portrait Sales By Sales Person2
SELECT [Portrait Sales By Sales Person1].Name, OrderItems.Description, [Portrait Sales By Sales Person1].Units, [Portrait Sales By Sales Person1].OrderDate
FROM OrderItems INNER JOIN [Portrait Sales By Sales Person1] ON OrderItems.OrderItemID = [Portrait Sales By Sales Person1].OrderItemID
GROUP BY [Portrait Sales By Sales Person1].Name, OrderItems.Description, [Portrait Sales By Sales Person1].Units, [Portrait Sales By Sales Person1].OrderDate
UNION SELECT Users.[FirstName]+' '+[LastName] AS Name, ' TOTAL ORDERS ', Count(Orders.OrderDate) AS CountOfOrderDate, Orders.OrderDate
FROM Orders INNER JOIN Users ON Orders.UserID = Users.UserID
GROUP BY Users.[FirstName]+' '+[LastName], Orders.OrderDate;

