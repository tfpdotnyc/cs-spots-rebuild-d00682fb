-- Query: qStudioOrder2
SELECT Studios.Name, Count(qOrderReport2.OrderID) AS OrderCount, Sum(qOrderReport2.TotalOrder) AS OrderTotal
FROM qOrderReport2 INNER JOIN Studios ON qOrderReport2.Studio = Studios.Studio
WHERE (((qOrderReport2.OrderDate) >= #3/24/2002# And (qOrderReport2.OrderDate) <= #3/24/2003#))
GROUP BY Studios.Name;

