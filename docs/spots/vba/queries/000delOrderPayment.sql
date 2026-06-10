-- Query: 000delOrderPayment
DELETE OrderPayments.*
FROM 000delCust INNER JOIN (Orders INNER JOIN OrderPayments ON Orders.OrderID = OrderPayments.OrderID) ON [000delCust].CustomerID = Orders.CustomerID;

