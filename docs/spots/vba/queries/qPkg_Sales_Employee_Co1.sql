-- Query: qPkg_Sales_Employee_Co1
SELECT Orders.UserID, IIf(Len([OrderItemID])>2,Left([OrderItemID],3),Left([OrderItemID],1)) AS PkgType, Count(OrderDetails.OrderDetailID) AS [Count], Sum(OrderDetails.LineTotal) AS Total
FROM Orders INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE (((OrderDetails.OrderItemID) In ("SSPS","SSPD","SSPE","AD","AE","AS","BD","BE","BS","CD","CE","CS","DD","DE","DS","ED","EE","ES","FD","FE","FS","GD","GE","GS")))
GROUP BY Orders.UserID, IIf(Len([OrderItemID])>2,Left([OrderItemID],3),Left([OrderItemID],1));

