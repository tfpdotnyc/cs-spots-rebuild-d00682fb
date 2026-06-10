-- Query: Pose Count By Photographer1
SELECT [Pose Count By Photographer].Name, Count([Pose Count By Photographer].CountOfCustomerID) AS NumberOfOrders, [Pose Count By Photographer].CountOfCustomerID AS PoseCount, [Pose Count By Photographer].OrderDate
FROM [Pose Count By Photographer]
GROUP BY [Pose Count By Photographer].Name, [Pose Count By Photographer].CountOfCustomerID, [Pose Count By Photographer].OrderDate;

