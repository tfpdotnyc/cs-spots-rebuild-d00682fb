-- Query: qYearbookShootList_YBPose
SELECT PoseOrders.CustomerID, PoseOrders.PoseNo, PoseOrders.YB, IIf([Qty1]+[Qty2]+[Qty3]+[Qty4]+[Qty5]+[Qty6]+[Qty7]+[Qty8]+[Qty9]+[Qty10]<>0,True,False) AS OrderYB
FROM PoseOrders
WHERE (((PoseOrders.YB)=True));

