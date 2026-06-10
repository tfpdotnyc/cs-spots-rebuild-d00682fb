-- Query: 000AuditSessionsPayments
SELECT SessionPayments.SessionID, SessionPayments.Date, SessionPayments.Method, SessionPayments.Amount
FROM SessionPayments
ORDER BY SessionPayments.SessionID;

