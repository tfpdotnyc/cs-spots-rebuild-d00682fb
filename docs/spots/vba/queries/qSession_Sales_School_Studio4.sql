-- Query: qSession_Sales_School_Studio4
SELECT Studios.Name AS Studio, Schools.School, qSession_Sales_School_Studio3.[Basic Session] AS Expr1, Format([Basic Session]/[Total],"Percent") AS [% Basic Session], qSession_Sales_School_Studio3.[Graduate Session] AS Expr2, Format([Graduate Session]/[Total],"Percent") AS [% Graduate Session], qSession_Sales_School_Studio3.[Senior Session] AS Expr3, Format([Senior Session]/[Total],"Percent") AS [% Senior Session], qSession_Sales_School_Studio2.Total, 0 AS [1999 Session], 0 AS [% 1999 Session]
FROM ((qSession_Sales_School_Studio3 INNER JOIN qSession_Sales_School_Studio2 ON (qSession_Sales_School_Studio3.Studio = qSession_Sales_School_Studio2.Studio) AND (qSession_Sales_School_Studio3.SchoolID = qSession_Sales_School_Studio2.SchoolID)) INNER JOIN Schools ON qSession_Sales_School_Studio2.SchoolID = Schools.SchoolID) INNER JOIN Studios ON qSession_Sales_School_Studio2.Studio = Studios.Studio
ORDER BY Studios.Name, Schools.School;

