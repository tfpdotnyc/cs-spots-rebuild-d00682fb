-- Query: 000delCustCompositePages
DELETE CustomerCompositesPages.*
FROM 000delCust INNER JOIN CustomerCompositesPages ON [000delCust].CustomerID = CustomerCompositesPages.CustomerID;

