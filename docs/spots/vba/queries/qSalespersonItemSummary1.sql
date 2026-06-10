-- Query: qSalespersonItemSummary1
SELECT qOrderReport2.UserID, Count(qOrderReport2.OrderID) AS OCount
FROM qOrderReport2
WHERE (((qOrderReport2.OrderDate) >= #1/1/1980# And (qOrderReport2.OrderDate) <= #12/31/9999#))
GROUP BY qOrderReport2.UserID;

