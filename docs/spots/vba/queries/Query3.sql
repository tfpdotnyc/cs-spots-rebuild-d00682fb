-- Query: Query3
SELECT Customers.CustomerID, Customers.LastName, Customers.FirstName, Customers.Phone, Customers.CoCustomerID, "S" AS PayType, SessionPayments.CreditCardType, SessionPayments.CreditCardNumber, SessionPayments.ExpirationDate, SessionPayments.CCSecurityCode, SessionPayments.Amount, SessionPayments.Date
FROM (Customers INNER JOIN Sessions ON Customers.CustomerID = Sessions.CustomerID) INNER JOIN SessionPayments ON Sessions.SessionID = SessionPayments.SessionID
WHERE (((SessionPayments.Method)=2));

