-- Query: 000delCustComposite
DELETE CustomerComposites.*
FROM 000delCust INNER JOIN CustomerComposites ON [000delCust].CustomerID = CustomerComposites.CustomerID;

