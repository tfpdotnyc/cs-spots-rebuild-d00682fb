-- Query: qSession_Sales_School_Studio_Rpt
SELECT 1 AS Sort, Studios.Name, qSession_Sales_School_Studio1.Studio, Schools.School, qSession_Sales_School_Studio1.SchoolID, qSession_Sales_School_Studio1.SessionItemID, qSession_Sales_School_Studio1.Description, qSession_Sales_School_Studio1.CountOfSessionDetailID, qSession_Sales_School_Studio2.Total, ([CountOfSessionDetailID]/[Total])*100 AS PctOfTotal
FROM ((qSession_Sales_School_Studio1 INNER JOIN qSession_Sales_School_Studio2 ON (qSession_Sales_School_Studio1.SchoolID = qSession_Sales_School_Studio2.SchoolID) AND (qSession_Sales_School_Studio1.Studio = qSession_Sales_School_Studio2.Studio)) INNER JOIN Studios ON qSession_Sales_School_Studio1.Studio = Studios.Studio) INNER JOIN Schools ON qSession_Sales_School_Studio1.SchoolID = Schools.SchoolID
ORDER BY 1, Studios.Name, Schools.School
UNION SELECT 2 AS Sort, Studios.Name, qSession_Sales_School_Studio1B.Studio, 'Total' AS School, 0 AS SchoolID, qSession_Sales_School_Studio1B.SessionItemID, qSession_Sales_School_Studio1B.Description, qSession_Sales_School_Studio1B.CountOfSessionDetailID, qSession_Sales_School_Studio2B.Total, ([CountOfSessionDetailID]/[Total])*100 AS PctOfTotal
FROM (qSession_Sales_School_Studio1B INNER JOIN Studios ON qSession_Sales_School_Studio1B.Studio = Studios.Studio) INNER JOIN qSession_Sales_School_Studio2B ON qSession_Sales_School_Studio1B.Studio = qSession_Sales_School_Studio2B.Studio
ORDER BY 2, Studios.Name;

