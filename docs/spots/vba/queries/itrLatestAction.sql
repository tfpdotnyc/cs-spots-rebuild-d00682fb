-- Query: itrLatestAction
SELECT Actions.ActionID, Actions.OrderID, Actions.Action, Actions.Date, Actions.UserID, Actions.Studio, Actions.ExtraID, Actions.Update, Actions.YBO, Actions.Spotting, Actions.Reprint, Actions.Partial, Actions.PendingItem
FROM Actions INNER JOIN itrLatestAction_Select ON (Actions.OrderID = itrLatestAction_Select.OrderID) AND (Actions.Action = itrLatestAction_Select.MaxOfAction);

