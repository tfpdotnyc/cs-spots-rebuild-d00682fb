-- Query: qAction5
SELECT Actions.OrderID, Actions.Date, Actions.ExtraID, Actions.Update, Actions.Action
FROM Actions
WHERE (((Actions.Action)=5))
ORDER BY Actions.OrderID;

