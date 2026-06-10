-- Query: 000delDeposit
DELETE DepositPayments.*
FROM 000delCust INNER JOIN DepositPayments ON [000delCust].CustomerID = DepositPayments.CustomerID;

