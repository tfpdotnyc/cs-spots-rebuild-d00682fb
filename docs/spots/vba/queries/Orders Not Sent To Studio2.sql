-- Query: Orders Not Sent To Studio2
SELECT Max([Orders Not Sent To Studio1].OrderDate) AS [Order Date], [Orders Not Sent To Studio1].CustomerID, Max([Orders Not Sent To Studio1].Date) AS [Action Date], Max([Orders Not Sent To Studio1].Action) AS MaxOfAction
FROM [Orders Not Sent To Studio1]
GROUP BY [Orders Not Sent To Studio1].CustomerID
ORDER BY Max([Orders Not Sent To Studio1].OrderDate);

