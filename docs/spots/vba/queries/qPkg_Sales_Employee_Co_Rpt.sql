-- Query: qPkg_Sales_Employee_Co_Rpt
SELECT Orders.UserID, Users.FirstName, OrderDetails.OrderItemID AS PkgType, Count(OrderDetails.OrderDetailID) AS [Count], Sum(OrderDetails.LineTotal) AS Total
FROM (Orders INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) INNER JOIN Users ON Orders.UserID = Users.UserID
GROUP BY Orders.UserID, Users.FirstName, OrderDetails.OrderItemID;

