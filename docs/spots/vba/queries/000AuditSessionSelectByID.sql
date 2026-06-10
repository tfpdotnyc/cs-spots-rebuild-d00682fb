-- Query: 000AuditSessionSelectByID
SELECT Customers.CustomerID
FROM (Customers INNER JOIN Sessions ON Customers.CustomerID = Sessions.CustomerID) INNER JOIN SessionDetail ON Sessions.SessionID = SessionDetail.SessionID
WHERE (((SessionDetail.SessionItemID)='SE') AND ((Sessions.DateTime)>=#2/16/2000# And (Sessions.DateTime)<=#2/16/2006 23:59:59#))
GROUP BY Customers.CustomerID;

