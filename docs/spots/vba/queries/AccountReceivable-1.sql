-- Query: AccountReceivable-1
SELECT AccountReceivable0.OrderID, ActionItems.Description
FROM ActionItems INNER JOIN AccountReceivable0 ON ActionItems.Action = AccountReceivable0.ActionNumber;

