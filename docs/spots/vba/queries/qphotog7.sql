-- Query: qphotog7
SELECT qphotog3.PhotographerID, Count(qphotog3.CustomerID) AS [# ACES]
FROM qphotog3 LEFT JOIN Orders ON qphotog3.CustomerID = Orders.CustomerID
WHERE (((Orders.CustomerID) Is Null))
GROUP BY qphotog3.PhotographerID;

