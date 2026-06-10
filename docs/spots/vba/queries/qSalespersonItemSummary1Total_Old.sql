-- Query: qSalespersonItemSummary1Total_Old
SELECT 'Total' AS UID, Count(qOrderReport2.OrderID) AS OCount
FROM qOrderReport2 INNER JOIN (OrderDetails INNER JOIN OrderItems ON OrderDetails.OrderItemID = OrderItems.OrderItemID) ON qOrderReport2.OrderID = OrderDetails.OrderID
WHERE (((qOrderReport2.OrderDate)>=#7/30/2004# And (qOrderReport2.OrderDate)<=#7/30/2004 23:59:59#))
GROUP BY 'Total';

