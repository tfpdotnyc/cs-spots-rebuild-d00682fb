-- Query: Pose Count By Sales Person1
SELECT [Pose Count By Sales Person].Name, Count([Pose Count By Sales Person].CountOfCustomerID) AS NumberOfOrders, [Pose Count By Sales Person].CountOfCustomerID AS PoseCount, [Pose Count By Sales Person].OrderDate
FROM [Pose Count By Sales Person]
GROUP BY [Pose Count By Sales Person].Name, [Pose Count By Sales Person].CountOfCustomerID, [Pose Count By Sales Person].OrderDate;

