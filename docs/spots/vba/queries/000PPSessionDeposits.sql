-- Query: 000PPSessionDeposits
SELECT DepositPayments.CustomerID, Sessions.SessionNumber, DepositPayments.SessionID, DepositPayments.Date, DepositPayments.Amount, IIf([Method]=0,'Cash',IIf([Method]=1,'Check',IIf([Method]=2,'Credit Card','Misc'))) AS MethodDesc, MiscPaymentTypes.Payment_Description
FROM (DepositPayments INNER JOIN Sessions ON DepositPayments.SessionID = Sessions.SessionID) LEFT JOIN MiscPaymentTypes ON DepositPayments.CreditCardType = MiscPaymentTypes.Payment_Description
WHERE (((DepositPayments.SessionID)<>0));

