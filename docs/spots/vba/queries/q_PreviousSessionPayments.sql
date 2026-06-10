-- Query: q_PreviousSessionPayments
PARAMETERS pSessionID Long;
SELECT SessionPayments.Date, SessionPayments.Amount+SessionPayments.AdditionalCash AS AmountPaid, IIf(SessionPayments.Method=0,"Cash",IIf(SessionPayments.Method=1,"Check","Credit")) AS Method, SessionPayments.CheckNumber, Trim(Users.FirstName)+' '+Users.LastName AS TransactionBy, Studios.Name AS Location, SessionPayments.PaymentID, SessionPayments.Deposit
FROM (SessionPayments INNER JOIN Studios ON SessionPayments.Studio = Studios.Studio) INNER JOIN Users ON SessionPayments.UserID = Users.UserID
WHERE (((([SessionPayments].[SessionID]))=[pSessionID]))
ORDER BY SessionPayments.PaymentID;

