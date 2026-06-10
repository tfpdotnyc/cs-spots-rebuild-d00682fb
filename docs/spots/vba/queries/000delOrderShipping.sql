-- Query: 000delOrderShipping
DELETE Shipping.*
FROM (000delCust INNER JOIN Orders ON [000delCust].CustomerID = Orders.CustomerID) INNER JOIN Shipping ON Orders.OrderID = Shipping.OrderID;

