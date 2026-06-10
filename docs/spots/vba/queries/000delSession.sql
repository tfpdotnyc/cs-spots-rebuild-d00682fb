-- Query: 000delSession
DELETE Sessions.*
FROM 000delCust INNER JOIN Sessions ON [000delCust].CustomerID = Sessions.CustomerID;

