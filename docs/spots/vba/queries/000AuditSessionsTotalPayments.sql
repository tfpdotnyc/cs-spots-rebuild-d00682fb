-- Query: 000AuditSessionsTotalPayments
SELECT SessionPayments.SessionID, Sum(SessionPayments.Amount) AS TotalPayments
FROM SessionPayments
GROUP BY SessionPayments.SessionID
ORDER BY SessionPayments.SessionID;

