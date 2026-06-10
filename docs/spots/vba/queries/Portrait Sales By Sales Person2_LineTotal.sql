-- Query: Portrait Sales By Sales Person2_LineTotal
SELECT [Portrait Sales By Sales Person1_LineTotal].Name, OrderItems.Description, [Portrait Sales By Sales Person1_LineTotal].LineTotal, [Portrait Sales By Sales Person1_LineTotal].OrderDate
FROM OrderItems INNER JOIN [Portrait Sales By Sales Person1_LineTotal] ON OrderItems.OrderItemID = [Portrait Sales By Sales Person1_LineTotal].OrderItemID
GROUP BY [Portrait Sales By Sales Person1_LineTotal].Name, OrderItems.Description, [Portrait Sales By Sales Person1_LineTotal].LineTotal, [Portrait Sales By Sales Person1_LineTotal].OrderDate
UNION SELECT Users.[FirstName]+' '+[LastName] AS Name, ' TOTAL ORDERS ' AS Expr1, Sum(OrderDetails.LineTotal) AS SumOfLineTotal, Orders.OrderDate
FROM (Orders INNER JOIN Users ON Orders.UserID = Users.UserID) INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY Users.[FirstName]+' '+[LastName], Orders.OrderDate;

