-- Query: Query4
SELECT Customers.CustomerID, Customers.LastName, Customers.FirstName, Customers.Phone, Customers.CoCustomerID, "O" AS PayType, OrderPayments.CreditCardType, OrderPayments.CreditCardNumber, OrderPayments.ExpirationDate, OrderPayments.CCSecurityCode, OrderPayments.Amount, OrderPayments.Date
FROM (Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID) INNER JOIN OrderPayments ON Orders.OrderID = OrderPayments.OrderID
WHERE (((OrderPayments.Method)=2));

