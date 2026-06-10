-- Query: qSession_Sales_Employee_Studio_Rpt
SELECT 1 AS Sort, qSession_Sales_Employee_Studio1.Studio, qSession_Sales_Employee_Studio1.Name, qSession_Sales_Employee_Studio1.UserID, qSession_Sales_Employee_Studio1.FirstName, qSession_Sales_Employee_Studio1.SessionItemID, qSession_Sales_Employee_Studio1.Description, qSession_Sales_Employee_Studio1.CountOfSessionDetailID, qSession_Sales_Employee_Studio2.Total, ([CountOfSessionDetailID]/[Total])*100 AS PctOfTotal
FROM qSession_Sales_Employee_Studio1 INNER JOIN qSession_Sales_Employee_Studio2 ON (qSession_Sales_Employee_Studio1.UserID = qSession_Sales_Employee_Studio2.UserID) AND (qSession_Sales_Employee_Studio1.Studio = qSession_Sales_Employee_Studio2.Studio)
ORDER BY 1, qSession_Sales_Employee_Studio1.Name, qSession_Sales_Employee_Studio1.FirstName
UNION SELECT 2 AS Sort, qSession_Sales_Employee_Studio1B.Studio, qSession_Sales_Employee_Studio1B.Name, 0 AS UserID, 'Total' AS FirstName, qSession_Sales_Employee_Studio1B.SessionItemID, qSession_Sales_Employee_Studio1B.Description, qSession_Sales_Employee_Studio1B.CountOfSessionDetailID, qSession_Sales_Employee_Studio2B.Total, ([CountOfSessionDetailID]/[Total])*100 AS PctOfTotal
FROM qSession_Sales_Employee_Studio1B INNER JOIN qSession_Sales_Employee_Studio2B ON qSession_Sales_Employee_Studio1B.Studio = qSession_Sales_Employee_Studio2B.Studio;

