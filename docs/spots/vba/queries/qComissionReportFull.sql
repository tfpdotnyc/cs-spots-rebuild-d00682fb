-- Query: qComissionReportFull
SELECT IIf([Users.FirstName]='Total',2,1) AS NameSort, Users.FirstName, Users.LastName, 1 AS LineSort, "Count" AS LineItem, OrderItems.ItemType, Count(Orders.OrderID) AS CountOfOrderID
FROM OrderItems INNER JOIN ((Orders LEFT JOIN Users ON Orders.UserID = Users.UserID) INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON OrderItems.OrderItemID = OrderDetails.OrderItemID
WHERE (((Orders.OrderDate)>=#1/1/1990# And (Orders.OrderDate)<=#12/31/9999#) AND ((Orders.Studio)<>99) AND ((OrderItems.Comission)=True))
GROUP BY Users.FirstName, Users.LastName, 1, "Count", OrderItems.ItemType
UNION
SELECT IIf([Users.FirstName]='Total',2,1) AS NameSort, Users.FirstName, Users.LastName, 2 AS LineSort, "Total Sales" AS LineItem, OrderItems.ItemType, Format(Sum(Orders.OrderTotal),"Currency") AS SumOfOrderTotal
FROM OrderItems INNER JOIN ((Orders LEFT JOIN Users ON Orders.UserID = Users.UserID) INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON OrderItems.OrderItemID = OrderDetails.OrderItemID
WHERE (((Orders.OrderDate)>=#1/1/1990# And (Orders.OrderDate)<=#12/31/9999#) AND ((Orders.Studio)<>99) AND ((OrderItems.Comission)=True))
GROUP BY Users.FirstName, Users.LastName, 2, "Total Sales", OrderItems.ItemType
UNION
SELECT IIf([Users.FirstName]='Total',2,1) AS NameSort, Users.FirstName, Users.LastName, 3 AS LineSort, "Comission Amount" AS LineItem, OrderItems.ItemType, Format(Sum([OrderTotal]*([ComissionRate]/100)),"Currency") AS ComissionAmt
FROM OrderItems INNER JOIN ((Orders LEFT JOIN Users ON Orders.UserID = Users.UserID) INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON OrderItems.OrderItemID = OrderDetails.OrderItemID
WHERE (((Orders.OrderDate)>=#1/1/1990# And (Orders.OrderDate)<=#12/31/9999#) AND ((Orders.Studio)<>99) AND ((OrderItems.Comission)=True))
GROUP BY Users.FirstName, Users.LastName, 3, "Comission Amount", OrderItems.ItemType
UNION
SELECT 2 AS NameSort, "TOTALS" As TC1, "TOTALS" As TC2, 1 AS LineSort, "Count" AS LineItem, OrderItems.ItemType, Count(Orders.OrderID) AS CountOfOrderID
FROM OrderItems INNER JOIN ((Orders LEFT JOIN Users ON Orders.UserID = Users.UserID) INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON OrderItems.OrderItemID = OrderDetails.OrderItemID
WHERE (((Orders.OrderDate)>=#1/1/1990# And (Orders.OrderDate)<=#12/31/9999#) AND ((Orders.Studio)<>99) AND ((OrderItems.Comission)=True))
GROUP BY "TOTALS", "TOTALS", 1, "Count", OrderItems.ItemType
UNION
SELECT 2 AS NameSort, "TOTALS" As TC1, "TOTALS" As TC2, 2 AS LineSort, "Total Sales" AS LineItem, OrderItems.ItemType, Format(Sum(Orders.OrderTotal),"Currency") AS SumOfOrderTotal
FROM OrderItems INNER JOIN ((Orders LEFT JOIN Users ON Orders.UserID = Users.UserID) INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON OrderItems.OrderItemID = OrderDetails.OrderItemID
WHERE (((Orders.OrderDate)>=#1/1/1990# And (Orders.OrderDate)<=#12/31/9999#) AND ((Orders.Studio)<>99) AND ((OrderItems.Comission)=True))
GROUP BY "TOTALS", "TOTALS", 2, "Total Sales", OrderItems.ItemType
UNION SELECT 2 AS NameSort, "TOTALS" As TC1,"TOTALS" As TC2, 3 AS LineSort, "Comission Amount" AS LineItem, OrderItems.ItemType, Format(Sum([OrderTotal]*([ComissionRate]/100)),"Currency") AS ComissionAmt
FROM OrderItems INNER JOIN ((Orders LEFT JOIN Users ON Orders.UserID = Users.UserID) INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON OrderItems.OrderItemID = OrderDetails.OrderItemID
WHERE (((Orders.OrderDate)>=#1/1/1990# And (Orders.OrderDate)<=#12/31/9999#) AND ((Orders.Studio)<>99) AND ((OrderItems.Comission)=True))
GROUP BY "TOTALS", "TOTALS", 3, "Comission Amount", OrderItems.ItemType;

