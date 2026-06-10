-- Query: q_OrderOverview
PARAMETERS pCustomerID IEEEDouble;
SELECT DISTINCTROW Orders.OrderNumber, Orders.OrderDate AS [Date], (SELECT First(OrderItems.Description) FROM OrderDetails LEFT JOIN OrderItems ON OrderDetails.OrderItemID = OrderItems.OrderItemID WHERE OrderDetails.OrderID = Orders.OrderID) AS OrderType, Trim(Users.FirstName)+' '+Trim(Users.LastName) AS OrderBy, Studios.Name AS Location, Orders.OrderTotal, Orders.Payments, (Orders.OrderTotal-Orders.Payments) AS Due, (SELECT Last(ActionItems.Description) FROM Actions LEFT JOIN ActionItems ON Actions.Action = ActionItems.Action WHERE Actions.OrderID = Orders.OrderID) AS Status, Orders.Rush, Orders.OrderID, Orders.Event
FROM (Orders INNER JOIN Users ON Orders.UserID = Users.UserID) INNER JOIN Studios ON Orders.Studio = Studios.Studio
WHERE (((Orders.CustomerID)=[pCustomerID]))
ORDER BY Orders.OrderNumber;

