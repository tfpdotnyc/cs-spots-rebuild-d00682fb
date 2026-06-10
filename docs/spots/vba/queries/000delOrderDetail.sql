-- Query: 000delOrderDetail
DELETE OrderDetails.*
FROM 000delCust INNER JOIN (Orders INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) ON [000delCust].CustomerID = Orders.CustomerID;

