-- Query: qphotog3
SELECT Sessions.PhotographerID, Sessions.CustomerID
FROM Sessions
GROUP BY Sessions.PhotographerID, Sessions.CustomerID;

