-- Query: qCreditCardReport
SELECT Customers.CustomerID, Customers.LastName, Customers.FirstName, Customers.Phone, Customers.CoCustomerID, Customers.SchoolID, 'D' AS PayType, Sessions.Studio, DepositPayments.CreditCardType, DepositPayments.CreditCardNumber, DepositPayments.ExpirationDate, DepositPayments.CCSecurityCode, DepositPayments.Amount, DepositPayments.Date
FROM (Customers INNER JOIN Sessions ON Customers.CustomerID = Sessions.CustomerID) INNER JOIN DepositPayments ON Sessions.SessionID = DepositPayments.SessionID
Where (((DepositPayments.Method) = 2))
Union
SELECT Customers.CustomerID, Customers.LastName, Customers.FirstName, Customers.Phone, Customers.CoCustomerID, Customers.SchoolID, 'O' AS PayType, Orders.Studio, OrderPayments.CreditCardType, OrderPayments.CreditCardNumber, OrderPayments.ExpirationDate, OrderPayments.CCSecurityCode, OrderPayments.Amount, OrderPayments.Date
FROM (Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID) INNER JOIN OrderPayments ON Orders.OrderID = OrderPayments.OrderID
Where (((OrderPayments.Method) = 2))
UNION SELECT Customers.CustomerID, Customers.LastName, Customers.FirstName, Customers.Phone, Customers.CoCustomerID, Customers.SchoolID, 'S' AS PayType, Sessions.Studio, SessionPayments.CreditCardType, SessionPayments.CreditCardNumber, SessionPayments.ExpirationDate, SessionPayments.CCSecurityCode, SessionPayments.Amount, SessionPayments.Date
FROM (Customers INNER JOIN Sessions ON Customers.CustomerID = Sessions.CustomerID) INNER JOIN SessionPayments ON Sessions.SessionID = SessionPayments.SessionID
WHERE (((SessionPayments.Method)=2));

