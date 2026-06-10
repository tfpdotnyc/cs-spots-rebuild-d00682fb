-- Query: qComissionReportOrderTotal
SELECT Users.FirstName, Users.LastName, 2 AS LineSort, "Total Sales" AS LineItem, OrderItems.ItemType, Sum(Orders.OrderTotal) AS SumOfOrderTotal
FROM OrderItems INNER JOIN ((Orders LEFT JOIN Users ON Orders.UserID = Users.UserID) INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON OrderItems.OrderItemID = OrderDetails.OrderItemID
WHERE (((Orders.OrderDate)>=#1/1/1990# And (Orders.OrderDate)<=#12/31/9999#) AND ((Orders.Studio)<>99) AND ((OrderItems.Comission)=True))
GROUP BY Users.FirstName, Users.LastName, 2, "Total Sales", OrderItems.ItemType;

