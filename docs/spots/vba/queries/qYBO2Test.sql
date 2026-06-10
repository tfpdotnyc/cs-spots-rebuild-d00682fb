-- Query: qYBO2Test
SELECT Sessions.CustomerID
FROM Sessions
WHERE (((Sessions.YBO)=False))
GROUP BY Sessions.CustomerID;

