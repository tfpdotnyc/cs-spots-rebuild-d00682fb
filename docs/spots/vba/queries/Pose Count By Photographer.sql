-- Query: Pose Count By Photographer
SELECT [FirstName]+' '+[LastName] AS Name, Count(PoseOrders.CustomerID) AS CountOfCustomerID, Orders.OrderDate
FROM Orders INNER JOIN ((PoseOrders INNER JOIN Sessions ON (PoseOrders.CustomerID = Sessions.CustomerID) AND (PoseOrders.SessionNumber = Sessions.SessionNumber)) INNER JOIN Photographers ON Sessions.PhotographerID = Photographers.PhotographerID) ON Orders.CustomerID = Sessions.CustomerID
WHERE (((PoseOrders.OrderNumber) <> 'YB' Or (PoseOrders.OrderNumber) = ''))
GROUP BY [FirstName]+' '+[LastName], Orders.OrderDate, Orders.CustomerID;

