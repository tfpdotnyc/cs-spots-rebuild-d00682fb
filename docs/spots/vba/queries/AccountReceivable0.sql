-- Query: AccountReceivable0
SELECT Orders.OrderID, Max(Actions.Action) AS ActionNumber
FROM Orders INNER JOIN (ActionItems INNER JOIN Actions ON ActionItems.Action = Actions.Action) ON Orders.OrderID = Actions.OrderID
GROUP BY Orders.OrderID;

