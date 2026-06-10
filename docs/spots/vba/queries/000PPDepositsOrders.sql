-- Query: 000PPDepositsOrders
SELECT DepositPayments.CustomerID, Orders.OrderNumber, DepositPayments.SessionID, DepositPayments.SessionPaymentID, DepositPayments.OrderID, DepositPayments.Date, DepositPayments.Amount, IIf([Method]=0,'Cash',IIf([Method]=1,'Check',IIf([Method]=2,'Credit Card','Misc'))) AS MethodDesc, MiscPaymentTypes.Payment_Description
FROM (DepositPayments LEFT JOIN MiscPaymentTypes ON DepositPayments.CreditCardType = MiscPaymentTypes.Payment_Description) INNER JOIN Orders ON DepositPayments.OrderID = Orders.OrderID
WHERE (((DepositPayments.SessionPaymentID)<>0) AND ((DepositPayments.OrderID)<>0));

