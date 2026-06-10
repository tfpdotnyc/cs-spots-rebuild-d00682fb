-- Query: 000delCustCompositeUtility
DELETE CustomerCompositesUtility.*
FROM 000delCust INNER JOIN CustomerCompositesUtility ON [000delCust].CustomerID = CustomerCompositesUtility.CustomerID;

