-- Query: Orders Not Sent To Studio3
SELECT [Orders Not Sent To Studio2].[Order Date], [Orders Not Sent To Studio2].CustomerID, ActionItems.Description, [Orders Not Sent To Studio2].[Action Date]
FROM [Orders Not Sent To Studio2] INNER JOIN ActionItems ON [Orders Not Sent To Studio2].MaxOfAction = ActionItems.Action;

