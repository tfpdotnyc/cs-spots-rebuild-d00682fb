-- Query: qhotlist2
SELECT Actions.Action, ActionItems.Description, qhotlist1.OrderID, Actions.Date, ActionItems.Days, DateAdd('d',[Days],[Date]) AS CDate, Now() AS Expr1
FROM (qhotlist1 INNER JOIN Actions ON (qhotlist1.OrderID = Actions.OrderID) AND (qhotlist1.MaxOfAction = Actions.Action)) INNER JOIN ActionItems ON Actions.Action = ActionItems.Action
WHERE (((Actions.Action)<>15 And (Actions.Action)<>16) AND ((DateAdd('d',[Days],[Date]))<Now()));

