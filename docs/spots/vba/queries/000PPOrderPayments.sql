-- Query: 000PPOrderPayments
SELECT Orders.CustomerID, Orders.OrderNumber, OrderPayments.Date, OrderPayments.Amount, IIf([Method]=0,'Cash',IIf([Method]=1,'Check',IIf([Method]=2,'Credit Card','Misc'))) AS MethodDesc, MiscPaymentTypes.Payment_Description
FROM (Orders INNER JOIN OrderPayments ON Orders.OrderID = OrderPayments.OrderID) LEFT JOIN MiscPaymentTypes ON OrderPayments.CreditCardType = MiscPaymentTypes.Payment_Description;

