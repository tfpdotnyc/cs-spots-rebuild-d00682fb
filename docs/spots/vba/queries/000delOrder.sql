-- Query: 000delOrder
DELETE Orders.*
FROM 000delCust INNER JOIN Orders ON [000delCust].CustomerID = Orders.CustomerID;

