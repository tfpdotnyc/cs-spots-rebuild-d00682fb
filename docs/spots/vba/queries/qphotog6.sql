-- Query: qphotog6
SELECT qphotog5.PhotographerID, Avg(qphotog5.SumOfLineTotal) AS [PACKAGE AVERAGE]
FROM qphotog5
GROUP BY qphotog5.PhotographerID;

