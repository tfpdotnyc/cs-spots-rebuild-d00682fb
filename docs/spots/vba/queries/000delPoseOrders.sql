-- Query: 000delPoseOrders
DELETE PoseOrders.*
FROM 000delCust INNER JOIN PoseOrders ON [000delCust].CustomerID = PoseOrders.CustomerID;

