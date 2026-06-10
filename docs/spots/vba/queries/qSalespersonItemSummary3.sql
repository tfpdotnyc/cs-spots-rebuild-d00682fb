-- Query: qSalespersonItemSummary3
SELECT Users.FirstName, qSalespersonItemSummary1.OCount, qSalespersonItemSummary2.ItemType, Count(qSalespersonItemSummary2.OrderDetailID) AS ICount
FROM (qSalespersonItemSummary1 INNER JOIN Users ON qSalespersonItemSummary1.UserID = Users.UserID) INNER JOIN qSalespersonItemSummary2 ON qSalespersonItemSummary1.UserID = qSalespersonItemSummary2.UserID
GROUP BY Users.FirstName, qSalespersonItemSummary1.OCount, qSalespersonItemSummary2.ItemType;

