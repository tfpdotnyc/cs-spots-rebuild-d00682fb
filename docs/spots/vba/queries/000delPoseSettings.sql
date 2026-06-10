-- Query: 000delPoseSettings
DELETE PoseSettings.*
FROM 000delCust INNER JOIN PoseSettings ON [000delCust].CustomerID = PoseSettings.CustomerID;

