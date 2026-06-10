-- Query: qSalespersonOrder2
SELECT qOrderReport2.UserID, Count(PoseOrders.PoseNo) AS PCount
FROM qOrderReport2 INNER JOIN PoseOrders ON qOrderReport2.OrderNumber = PoseOrders.OrderNumber
WHERE (((qOrderReport2.Studio) <> 99) And ((qOrderReport2.OrderDate) >= #1/1/1980# And (qOrderReport2.OrderDate) <= #12/31/9999#) AND ((IIf(IsNull([Qty1]),0,[Qty1])+IIf(IsNull([Qty2]),0,[Qty2])+IIf(IsNull([Qty3]),0,[Qty3])+IIf(IsNull([Qty4]),0,[Qty4])+IIf(IsNull([Qty5]),0,[Qty5])+IIf(IsNull([Qty6]),0,[Qty6])+IIf(IsNull([Qty7]),0,[Qty7])+IIf(IsNull([Qty8]),0,[Qty8])+IIf(IsNull([Qty9]),0,[Qty9])+IIf(IsNull([Qty10]),0,[Qty10]))>0))
GROUP BY qOrderReport2.UserID;

