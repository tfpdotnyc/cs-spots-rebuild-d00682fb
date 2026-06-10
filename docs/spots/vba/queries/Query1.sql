-- Query: Query1
INSERT INTO PoseOrdersNew ( CustomerID, PoseNo, Qty1, Qty2, Qty3, Qty4, Qty5, Qty6, Qty7, Temp8, Qty8, Temp9, Qty9, Temp10, Qty10, YB, Linen, Canvas, [By], EffDate, SessionNumber )
SELECT PoseOrders.CustomerID, PoseOrders.PoseNo, PoseOrders.Qty1, PoseOrders.Qty2, PoseOrders.Qty3, PoseOrders.Qty4, PoseOrders.Qty5, PoseOrders.Qty6, PoseOrders.Qty7, PoseOrders.Temp8, PoseOrders.Qty8, PoseOrders.Temp9, PoseOrders.Qty9, PoseOrders.Temp10, PoseOrders.Qty10, PoseOrders.YB, PoseOrders.Linen, PoseOrders.Canvas, PoseOrders.By, PoseOrders.EffDate, PoseOrders.SessionNumber
FROM PoseOrders;

