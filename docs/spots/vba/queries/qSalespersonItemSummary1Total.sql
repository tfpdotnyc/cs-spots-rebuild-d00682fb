-- Query: qSalespersonItemSummary1Total
SELECT 'Total' AS UID, Count(qOrderReport2.OrderID) AS OCount
FROM qOrderReport2
WHERE (((qOrderReport2.OrderDate)>=#3/8/2000# And (qOrderReport2.OrderDate)<=#3/8/2010 23:59:59#))
GROUP BY 'Total';

