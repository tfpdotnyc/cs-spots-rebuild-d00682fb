-- Query: qSession_Sales_School_Co_Rpt
SELECT 1 AS Sort, Schools.School, qSession_Sales_School_Co1.SchoolID, qSession_Sales_School_Co1.SessionItemID, qSession_Sales_School_Co1.Description, qSession_Sales_School_Co1.CountOfSessionDetailID, qSession_Sales_School_Co2.Total, ([CountOfSessionDetailID]/[Total])*100 AS PctOfTotal
FROM (qSession_Sales_School_Co1 INNER JOIN qSession_Sales_School_Co2 ON qSession_Sales_School_Co1.SchoolID = qSession_Sales_School_Co2.SchoolID) INNER JOIN Schools ON qSession_Sales_School_Co1.SchoolID = Schools.SchoolID
ORDER BY 1, Schools.School
UNION SELECT 2 AS Sort, 'Total' AS School, 0 AS SchoolID, qSession_Sales_School_Co1B.SessionItemID, qSession_Sales_School_Co1B.Description, qSession_Sales_School_Co1B.CountOfSessionDetailID, qSession_Sales_School_Co2B.Total, ([CountOfSessionDetailID]/[Total])*100 AS PctOfTotal
From qSession_Sales_School_Co1B, qSession_Sales_School_Co2B
ORDER BY 2;

