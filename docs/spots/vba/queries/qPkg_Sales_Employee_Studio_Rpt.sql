-- Query: qPkg_Sales_Employee_Studio_Rpt
SELECT Orders.Studio, Studios.Name, Orders.UserID, Users.FirstName, OrderDetails.OrderItemID AS PkgType, Count(OrderDetails.OrderDetailID) AS [Count], Sum(OrderDetails.LineTotal) AS Total
FROM ((Orders INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID) INNER JOIN Users ON Orders.UserID = Users.UserID) INNER JOIN Studios ON Orders.Studio = Studios.Studio
GROUP BY Orders.Studio, Studios.Name, Orders.UserID, Users.FirstName, OrderDetails.OrderItemID;

