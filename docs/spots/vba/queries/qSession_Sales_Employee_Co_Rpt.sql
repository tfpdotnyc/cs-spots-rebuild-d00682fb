-- Query: qSession_Sales_Employee_Co_Rpt
SELECT 1 AS Sort, qSession_Sales_Employee_Co1.UserID, qSession_Sales_Employee_Co1.FirstName, qSession_Sales_Employee_Co1.SessionItemID, qSession_Sales_Employee_Co1.Description, qSession_Sales_Employee_Co1.CountOfSessionDetailID, qSession_Sales_Employee_Co2.Total, ([CountOfSessionDetailID]/[Total])*100 AS PctOfTotal
FROM qSession_Sales_Employee_Co1 INNER JOIN qSession_Sales_Employee_Co2 ON qSession_Sales_Employee_Co1.UserID = qSession_Sales_Employee_Co2.UserID
ORDER BY 1, qSession_Sales_Employee_Co1.FirstName
UNION SELECT 2 AS Sort, 0 AS UserID, 'Total' AS FirstName, qSession_Sales_Employee_Co1B.SessionItemID, qSession_Sales_Employee_Co1B.Description, qSession_Sales_Employee_Co1B.CountOfSessionDetailID, qSession_Sales_Employee_Co2B.Total, ([CountOfSessionDetailID]/[Total])*100 AS PctOfTotal
FROM qSession_Sales_Employee_Co1B, qSession_Sales_Employee_Co2B;

