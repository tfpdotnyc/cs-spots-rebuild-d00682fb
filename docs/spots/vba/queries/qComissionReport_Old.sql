-- Query: qComissionReport_Old
SELECT Users.FirstName, Users.LastName, 3 AS LineSort, 'Comission Amount' AS LineItem, OrderItems.ItemType, Sum([OrderTotal]*([ComissionRate]/100)) AS ComissionAmt
FROM OrderItems INNER JOIN ((Orders LEFT JOIN Users ON Orders.UserID = Users.UserID) INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON OrderItems.OrderItemID = OrderDetails.OrderItemID
WHERE (((Orders.OrderDate)>=#1/1/1990# And (Orders.OrderDate)<=#12/31/9999#) AND ((Orders.Studio)<>99) AND ((OrderItems.Comission)=True))
GROUP BY Users.FirstName, Users.LastName, 3, 'Comission Amount', OrderItems.ItemType;

