-- Query: qphotog1
SELECT Sessions.PhotographerID, Count(Sessions.CustomerID) AS [# PHOTOD]
FROM Sessions
WHERE (((Sessions.ResitID)=0))
GROUP BY Sessions.PhotographerID;

