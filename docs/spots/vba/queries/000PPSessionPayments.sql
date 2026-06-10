-- Query: 000PPSessionPayments
SELECT Sessions.CustomerID, Sessions.SessionNumber, SessionPayments.Date, SessionPayments.Amount, IIf([Method]=0,'Cash',IIf([Method]=1,'Check',IIf([Method]=2,'Credit Card','Misc'))) AS MethodDesc, MiscPaymentTypes.Payment_Description
FROM (Sessions INNER JOIN SessionPayments ON Sessions.SessionID = SessionPayments.SessionID) LEFT JOIN MiscPaymentTypes ON SessionPayments.CreditCardType = MiscPaymentTypes.Payment_Description;

