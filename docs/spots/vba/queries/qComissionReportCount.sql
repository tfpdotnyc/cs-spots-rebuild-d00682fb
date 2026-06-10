-- Query: qComissionReportCount
SELECT Users.FirstName, Users.LastName, 1 AS LineSort, "Count" AS LineItem, OrderItems.ItemType, Count(Orders.OrderID) AS CountOfOrderID
FROM OrderItems INNER JOIN ((Orders LEFT JOIN Users ON Orders.UserID = Users.UserID) INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON OrderItems.OrderItemID = OrderDetails.OrderItemID
WHERE (((Orders.OrderDate)>=#1/1/1990# And (Orders.OrderDate)<=#12/31/9999#) AND ((Orders.Studio)<>99) AND ((OrderItems.Comission)=True))
GROUP BY Users.FirstName, Users.LastName, 1, "Count", OrderItems.ItemType;

