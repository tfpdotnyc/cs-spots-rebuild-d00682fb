-- Query: qPhotographerOrder_TotalPoses
SELECT qCustomerPhotographer.PhotographerID, Count(qCustomerPoseOrders.TotalPoses) AS TotalPoses
FROM (Orders INNER JOIN qCustomerPoseOrders ON (Orders.CustomerID = qCustomerPoseOrders.CustomerID) AND (Orders.OrderNumber = qCustomerPoseOrders.OrderNumber)) INNER JOIN qCustomerPhotographer ON qCustomerPoseOrders.CustomerID = qCustomerPhotographer.CustomerID
GROUP BY qCustomerPhotographer.PhotographerID;

