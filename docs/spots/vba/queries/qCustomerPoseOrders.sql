-- Query: qCustomerPoseOrders
SELECT PoseOrders.CustomerID, Orders.OrderNumber, PoseOrders.PoseNo AS TotalPoses
FROM PoseOrders INNER JOIN Orders ON (PoseOrders.OrderNumber = Orders.OrderNumber) AND (PoseOrders.CustomerID = Orders.CustomerID)
WHERE (((IIf(IsNull([Qty1]), 0, [Qty1]) + IIf(IsNull([Qty2]), 0, [Qty2]) + IIf(IsNull([Qty3]), 0, [Qty3]) + IIf(IsNull([Qty4]), 0, [Qty4]) + IIf(IsNull([Qty5]), 0, [Qty5]) + IIf(IsNull([Qty6]), 0, [Qty6]) + IIf(IsNull([Qty7]), 0, [Qty7]) + IIf(IsNull([Qty8]), 0, [Qty8]) + IIf(IsNull([Qty9]), 0, [Qty9]) + IIf(IsNull([Qty10]), 0, [Qty10])) > 0) And ((Orders.OrderDate) >= #5/1/2008# And (Orders.OrderDate) <= #5/31/2008 11:59:59 PM#) And ((Orders.Studio) <> 99))
GROUP BY PoseOrders.CustomerID, Orders.OrderNumber, PoseOrders.PoseNo;

