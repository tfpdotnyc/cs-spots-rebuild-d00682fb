-- Query: 000delCustCompositeBorders
DELETE CustomerCompositesBorders.*
FROM 000delCust INNER JOIN CustomerCompositesBorders ON [000delCust].CustomerID = CustomerCompositesBorders.CustomerID;

