-- Query: q_ActionList
PARAMETERS pOrderID IEEEDouble;
SELECT ActionItems.Description, Actions.Date, Actions.UserID, Actions.Studio
FROM Actions LEFT JOIN ActionItems ON Actions.Action = ActionItems.Action
WHERE (((Actions.OrderID)=[pOrderID]));

