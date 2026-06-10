-- Query: 000delOrderActions
DELETE Actions.*
FROM 000delCust INNER JOIN (Orders INNER JOIN Actions ON Orders.OrderID = Actions.OrderID) ON [000delCust].CustomerID = Orders.CustomerID;

