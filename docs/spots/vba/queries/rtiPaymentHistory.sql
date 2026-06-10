-- Query: rtiPaymentHistory
SELECT SessionPayments.Date AS PayDate, Sessions.SessionNumber AS ID, SessionPayments.Amount+SessionPayments.AdditionalCash AS AmountPaid, IIf(SessionPayments.Method=0,'Cash',IIf(SessionPayments.Method=1,'Check',IIf(SessionPayments.Method=3,'Misc','Credit'))) AS Method, SessionPayments.CheckNumber, Trim(Users.FirstName)+' '+Users.LastName AS TransactionBy, Studios.Name AS Location, SessionPayments.PaymentID, IIf(SessionPayments.Deposit=0,'N','Y') AS Dep
FROM ((SessionPayments INNER JOIN Studios ON SessionPayments.Studio = Studios.Studio) INNER JOIN Users ON SessionPayments.UserID = Users.UserID) INNER JOIN Sessions ON SessionPayments.SessionID = Sessions.SessionID
Where (((Sessions.CustomerID) = 280002))
ORDER BY SessionPayments.Date, Sessions.SessionNumber
Union
SELECT OrderPayments.Date AS PayDate, Orders.OrderNumber AS ID, (OrderPayments.Amount+OrderPayments.AdditionalCash) AS AmountPaid, IIf(OrderPayments.Method=0,'Cash',IIf(OrderPayments.Method=1,'Check',IIf(OrderPayments.Method=3,'Misc','Credit'))) AS Method, OrderPayments.CheckNumber, Trim(Users.FirstName)+' '+Users.LastName AS TransactionBy, Studios.Name AS Location, OrderPayments.PaymentID, IIf(OrderPayments.Deposit=0,'N','Y') AS Dep
FROM ((OrderPayments INNER JOIN Studios ON OrderPayments.Studio = Studios.Studio) INNER JOIN Users ON OrderPayments.UserID = Users.UserID) INNER JOIN Orders ON OrderPayments.OrderID = Orders.OrderID
Where (((Orders.CustomerID) = 280002))
UNION SELECT DepositPayments.Date AS PayDate, DepositPayments.OrderID AS ID, (DepositPayments.Amount+DepositPayments.AdditionalCash) AS AmountPaid, IIf(DepositPayments.Method=0,'Cash',IIf(DepositPayments.Method=1,'Check',IIf(DepositPayments.Method=3,'Misc','Credit'))) AS Method, DepositPayments.CheckNumber, Trim(Users.FirstName)+' '+Users.LastName AS TransactionBy, Studios.Name AS Location, DepositPayments.PaymentID, IIf(DepositPayments.Deposit=0,'Y','Y') AS Dep
FROM ((DepositPayments INNER JOIN Studios ON DepositPayments.Studio = Studios.Studio) INNER JOIN Users ON DepositPayments.UserID = Users.UserID) INNER JOIN Customers ON DepositPayments.CustomerID = Customers.CustomerID
WHERE (((DepositPayments.CustomerID)= 280002));

