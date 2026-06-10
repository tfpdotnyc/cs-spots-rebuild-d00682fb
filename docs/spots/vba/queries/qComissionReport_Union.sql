-- Query: qComissionReport_Union
SELECT 1 AS NameSort, Users.FirstName, Users.LastName, qCommissionReport_OrdersTaken.OrdersTaken, 1 AS LineSort, 'Count' AS LineItem, OrderItems.ItemType, Count(Orders.OrderID) AS CountOfOrderID
FROM (OrderItems INNER JOIN ((Orders LEFT JOIN Users ON Orders.UserID = Users.UserID) INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON OrderItems.OrderItemID = OrderDetails.OrderItemID) LEFT JOIN qCommissionReport_OrdersTaken ON Users.UserID = qCommissionReport_OrdersTaken.UserID
Where (((Orders.OrderDate) >= #9/1/2004# And (Orders.OrderDate) <= #9/30/2004 11:59:59 PM#) And ((Orders.Studio) <> 99) And ((OrderItems.Comission) = True))
GROUP BY 1, Users.FirstName, Users.LastName, qCommissionReport_OrdersTaken.OrdersTaken, 1, 'Count', OrderItems.ItemType
UNION SELECT 1 AS NameSort, Users.FirstName, Users.LastName, qCommissionReport_OrdersTaken.OrdersTaken, 2 AS LineSort, 'Total Sales' AS LineItem, OrderItems.ItemType, Sum(OrderDetails.LineTotal) AS SumOfLineTotal
FROM (OrderItems INNER JOIN ((Orders LEFT JOIN Users ON Orders.UserID = Users.UserID) INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON OrderItems.OrderItemID = OrderDetails.OrderItemID) LEFT JOIN qCommissionReport_OrdersTaken ON Users.UserID = qCommissionReport_OrdersTaken.UserID
Where (((Orders.OrderDate) >= #9/1/2004# And (Orders.OrderDate) <= #9/30/2004 11:59:59 PM#) And ((Orders.Studio) <> 99) And ((OrderItems.Comission) = True))
GROUP BY 1, Users.FirstName, Users.LastName, qCommissionReport_OrdersTaken.OrdersTaken, 2, 'Total Sales', OrderItems.ItemType;

