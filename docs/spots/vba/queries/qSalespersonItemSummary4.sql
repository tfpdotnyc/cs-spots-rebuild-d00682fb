-- Query: qSalespersonItemSummary4
SELECT IIf([qSalespersonItemSummary4A.FirstName]='Total',2,1) AS Sort, qSalespersonItemSummary4A.FirstName, qSalespersonItemSummary4A.OCount, 'Item Count' AS RowDesc, qSalespersonItemSummary4A.ItemType, qSalespersonItemSummary4A.ICount, qSalespersonItemSummary4A.PctOfTot
From qSalespersonItemSummary4A
UNION SELECT IIf([qSalespersonItemSummary4A.FirstName]='Total',2,1) AS Sort, qSalespersonItemSummary4A.FirstName, qSalespersonItemSummary4A.OCount, 'Percent of Total' AS RowDesc, qSalespersonItemSummary4A.ItemType, qSalespersonItemSummary4A.PctOfTot, qSalespersonItemSummary4A.PctOfTot
FROM qSalespersonItemSummary4A;

