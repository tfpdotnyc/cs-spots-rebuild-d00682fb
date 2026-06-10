-- Query: qphotog2
SELECT Sessions.ResitID, Count(Sessions.CustomerID) AS [# RESITS]
FROM Sessions
WHERE (((Sessions.ResitID)<>0))
GROUP BY Sessions.ResitID;

