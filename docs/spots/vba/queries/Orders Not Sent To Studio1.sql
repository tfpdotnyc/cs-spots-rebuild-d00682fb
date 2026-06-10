-- Query: Orders Not Sent To Studio1
SELECT Orders.CustomerID, ActionItems.Description, Actions.Date, Actions.Action, Orders.OrderDate
FROM (Orders INNER JOIN Actions ON Orders.OrderID = Actions.OrderID) INNER JOIN ActionItems ON Actions.Action = ActionItems.Action
GROUP BY Orders.CustomerID, ActionItems.Description, Actions.Date, Actions.Action, Orders.OrderDate
HAVING (((Orders.CustomerID) Not In (Select Orders.CustomerId From Orders, Actions Where Actions.OrderId = Orders.OrderId And Actions.Action = 13;)));

