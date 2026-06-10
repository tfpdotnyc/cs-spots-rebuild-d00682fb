-- Query: qSchoolOrder2
SELECT qOrderReport2.School, Count(qOrderReport2.OrderID) AS OrderCount, Sum(qOrderReport2.TotalOrder) AS OrderTotal
FROM qOrderReport2
WHERE (((qOrderReport2.OrderDate) >= #3/24/2002# And (qOrderReport2.OrderDate) <= #3/24/2003#))
GROUP BY qOrderReport2.School;

