-- Query: qSalespersonItemSummary4A
SELECT qSalespersonItemSummary3.FirstName, qSalespersonItemSummary3.OCount, qSalespersonItemSummary3.ItemType, qSalespersonItemSummary3.ICount, IIf([OCount]=0,0,([ICount]/[OCount])*100) AS PctOfTot
From qSalespersonItemSummary3
UNION SELECT qSalespersonItemSummary3Total.UID, qSalespersonItemSummary3Total.OCount, qSalespersonItemSummary3Total.ItemType, qSalespersonItemSummary3Total.ICount, IIf([OCount]=0,0,([ICount]/[OCount])*100) AS PctOfTot
FROM qSalespersonItemSummary3Total;

