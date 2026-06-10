-- Query: Query2
SELECT SessionPayments.Date AS PayDate, Sessions.SessionNumber AS ID, SessionPayments.Amount+SessionPayments.AdditionalCash AS AmountPaid, IIf(SessionPayments.Method=0,'Cash',IIf(SessionPayments.Method=1,'Check','Credit')) AS Method, SessionPayments.CheckNumber, Trim(Users.FirstName)+' '+Users.LastName AS TransactionBy, Studios.Name AS Location, SessionPayments.PaymentID, SessionPayments.Deposit
FROM ((SessionPayments INNER JOIN Studios ON SessionPayments.Studio = Studios.Studio) INNER JOIN Users ON SessionPayments.UserID = Users.UserID) INNER JOIN Sessions ON SessionPayments.SessionID = Sessions.SessionID
WHERE (((Sessions.CustomerID)=90001))
ORDER BY SessionPayments.Date, Sessions.SessionNumber
UNION SELECT OrderPayments.Date AS PayDate, Orders.OrderNumber AS ID, (OrderPayments.Amount+OrderPayments.AdditionalCash) AS AmountPaid, IIf(OrderPayments.Method=0,'Cash',IIf(OrderPayments.Method=1,'Check','Credit')) AS Method, OrderPayments.CheckNumber, Trim(Users.FirstName)+' '+Users.LastName AS TransactionBy, Studios.Name AS Location, OrderPayments.PaymentID, OrderPayments.Deposit
FROM ((OrderPayments INNER JOIN Studios ON OrderPayments.Studio = Studios.Studio) INNER JOIN Users ON OrderPayments.UserID = Users.UserID) INNER JOIN Orders ON OrderPayments.OrderID = Orders.OrderID
WHERE (((Orders.CustomerID)=90001));

