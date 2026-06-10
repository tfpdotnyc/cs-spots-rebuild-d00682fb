-- Query: qShelfReport1
SELECT Orders.OrderID, Max(Actions.Action) AS MaxOfAction, Orders.CustomerID, Orders.Studio, Orders.OrderNumber, Orders.OrderTotal
FROM Orders LEFT JOIN Actions ON Orders.OrderID = Actions.OrderID
GROUP BY Orders.OrderID, Orders.CustomerID, Orders.Studio, Orders.OrderNumber, Orders.OrderTotal
HAVING (((Max(Actions.Action))=13 Or (Max(Actions.Action))=14));

