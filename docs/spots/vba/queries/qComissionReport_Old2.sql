-- Query: qComissionReport_Old2
SELECT 1 AS NameSort, Users.FirstName, Users.LastName, 1 AS LineSort, 'Count' AS LineItem, OrderItems.ItemType, Count(Orders.OrderID) AS CountOfOrderID
FROM OrderItems INNER JOIN ((Orders LEFT JOIN Users ON Orders.UserID = Users.UserID) INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON OrderItems.OrderItemID = OrderDetails.OrderItemID
Where (((Orders.OrderDate) >= #08/06/00 00:00:00 AM# And (Orders.OrderDate) <= #08/06/04 11:59:59 PM#) And ((Orders.Studio) <> 99) And ((OrderItems.Comission) = True))
GROUP BY 1, Users.FirstName, Users.LastName, 1, 'Count', OrderItems.ItemType
Union
SELECT 1 AS NameSort, Users.FirstName, Users.LastName, 2 AS LineSort, 'Total Sales' AS LineItem, OrderItems.ItemType, Sum(OrderDetails.LineTotal) AS SumOfLineTotal
FROM OrderItems INNER JOIN ((Orders LEFT JOIN Users ON Orders.UserID = Users.UserID) INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON OrderItems.OrderItemID = OrderDetails.OrderItemID
Where (((Orders.OrderDate) >= #08/06/00 00:00:00 AM# And (Orders.OrderDate) <= #08/06/04 11:59:59 PM#) And ((Orders.Studio) <> 99) And ((OrderItems.Comission) = True))
GROUP BY 1, Users.FirstName, Users.LastName, 2, 'Total Sales', OrderItems.ItemType
Union
SELECT 1 AS NameSort, Users.FirstName, Users.LastName, 3 AS LineSort, 'Comission Amount' AS LineItem, OrderItems.ItemType, Sum([LineTotal]*([ComissionRate]/100)) AS ComissionAmt
FROM OrderItems INNER JOIN ((Orders LEFT JOIN Users ON Orders.UserID = Users.UserID) INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON OrderItems.OrderItemID = OrderDetails.OrderItemID
Where (((Orders.OrderDate) >= #08/06/00 00:00:00 AM# And (Orders.OrderDate) <= #08/06/04 11:59:59 PM#) And ((Orders.Studio) <> 99) And ((OrderItems.Comission) = True))GROUP BY 1, Users.FirstName, Users.LastName, 3, 'Comission Amount', OrderItems.ItemType
Union
SELECT 2 AS NameSort, 'TOTALS' AS TC1, 'TOTALS' AS TC2, 1 AS LineSort, 'Count' AS LineItem, OrderItems.ItemType, Count(Orders.OrderID) AS CountOfOrderID
FROM OrderItems INNER JOIN ((Orders LEFT JOIN Users ON Orders.UserID = Users.UserID) INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON OrderItems.OrderItemID = OrderDetails.OrderItemID
Where (((Orders.OrderDate) >= #08/06/00 00:00:00 AM# And (Orders.OrderDate) <= #08/06/04 11:59:59 PM#) And ((Orders.Studio) <> 99) And ((OrderItems.Comission) = True))
GROUP BY 2, 'TOTALS', 'TOTALS', 1, 'Count', OrderItems.ItemType
Union
SELECT 2 AS NameSort, 'TOTALS' AS TC1, 'TOTALS' AS TC2, 2 AS LineSort, 'Total Sales' AS LineItem, OrderItems.ItemType, Sum(OrderDetails.LineTotal) AS SumOfLineTotal
FROM OrderItems INNER JOIN ((Orders LEFT JOIN Users ON Orders.UserID = Users.UserID) INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON OrderItems.OrderItemID = OrderDetails.OrderItemID
Where (((Orders.OrderDate) >= #08/06/00 00:00:00 AM# And (Orders.OrderDate) <= #08/06/04 11:59:59 PM#) And ((Orders.Studio) <> 99) And ((OrderItems.Comission) = True))
GROUP BY 2, 'TOTALS', 'TOTALS', 2, 'Total Sales', OrderItems.ItemType
UNION SELECT 2 AS NameSort, 'TOTALS' AS TC1, 'TOTALS' AS TC2, 3 AS LineSort, 'Comission Amount' AS LineItem, OrderItems.ItemType, Sum([LineTotal]*([ComissionRate]/100)) AS ComissionAmt
FROM OrderItems INNER JOIN ((Orders LEFT JOIN Users ON Orders.UserID = Users.UserID) INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON OrderItems.OrderItemID = OrderDetails.OrderItemID
Where (((Orders.OrderDate) >= #08/06/00 00:00:00 AM# And (Orders.OrderDate) <= #08/06/04 11:59:59 PM#) And ((Orders.Studio) <> 99) And ((OrderItems.Comission) = True))
GROUP BY 2, 'TOTALS', 'TOTALS', 3, 'Comission Amount', OrderItems.ItemType;

