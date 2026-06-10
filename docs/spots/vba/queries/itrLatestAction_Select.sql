-- Query: itrLatestAction_Select
SELECT Actions.OrderID, Max(Actions.Action) AS MaxOfAction
FROM Actions
GROUP BY Actions.OrderID;

