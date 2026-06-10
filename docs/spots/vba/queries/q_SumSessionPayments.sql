-- Query: q_SumSessionPayments
PARAMETERS pSessionID Long;
SELECT Sum(Amount+AdditionalCash) AS PreviousPayments
FROM SessionPayments
WHERE (((SessionPayments.SessionID)=[pSessionID]));

