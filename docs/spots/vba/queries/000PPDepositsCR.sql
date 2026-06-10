-- Query: 000PPDepositsCR
SELECT DepositPayments.CustomerID, Sessions.SessionNumber, DepositPayments.SessionID, DepositPayments.SessionPaymentID, DepositPayments.OrderID, DepositPayments.Date, DepositPayments.Amount, IIf([Method]=0,'Cash',IIf([Method]=1,'Check',IIf([Method]=2,'Credit Card','Misc'))) AS MethodDesc, MiscPaymentTypes.Payment_Description
FROM (DepositPayments LEFT JOIN MiscPaymentTypes ON DepositPayments.CreditCardType = MiscPaymentTypes.Payment_Description) INNER JOIN Sessions ON DepositPayments.SessionID = Sessions.SessionID
WHERE (((DepositPayments.OrderID)=0));

