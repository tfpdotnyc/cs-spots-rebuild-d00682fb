-- Query: q_PreviousOrderPayments
PARAMETERS pOrderID IEEEDouble;
SELECT OrderPayments.Date, (OrderPayments.Amount+OrderPayments.AdditionalCash) AS AmountPaid, IIf(OrderPayments.Method=0,"Cash",IIf(OrderPayments.Method=1,"Check","Credit")) AS Method, OrderPayments.CheckNumber, Trim(Users.FirstName)+' '+Users.LastName AS TransactionBy, Studios.Name AS Location, OrderPayments.PaymentID, OrderPayments.Deposit
FROM (OrderPayments INNER JOIN Studios ON OrderPayments.Studio = Studios.Studio) INNER JOIN Users ON OrderPayments.UserID = Users.UserID
WHERE (((([OrderPayments].[OrderID]))=[pOrderID]))
ORDER BY OrderPayments.PaymentID;

