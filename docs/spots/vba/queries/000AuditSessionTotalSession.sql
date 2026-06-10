-- Query: 000AuditSessionTotalSession
SELECT Customers.CustomerID, Sessions.SessionNumber, Sessions.SessionID, Sum(SessionDetail.LineTotal) AS SessionTotal
FROM (Customers INNER JOIN Sessions ON Customers.CustomerID = Sessions.CustomerID) INNER JOIN SessionDetail ON Sessions.SessionID = SessionDetail.SessionID
GROUP BY Customers.CustomerID, Sessions.SessionNumber, Sessions.SessionID
ORDER BY Customers.CustomerID, Sessions.SessionID;

