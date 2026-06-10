-- Query: qSession_Sales_School_Co4
SELECT Schools.School, qSession_Sales_School_Co3.[Basic Session] AS Expr1, Format([Basic Session]/[Total],"Percent") AS [% Basic Session], qSession_Sales_School_Co3.[Graduate Session] AS Expr2, Format([Graduate Session]/[Total],"Percent") AS [% Graduate Session], qSession_Sales_School_Co3.[Senior Session] AS Expr3, Format([Senior Session]/[Total],"Percent") AS [% Senior Session], qSession_Sales_School_Co2.Total, 0 AS [1999 Session], 0 AS [% 1999 Session]
FROM (qSession_Sales_School_Co3 INNER JOIN qSession_Sales_School_Co2 ON qSession_Sales_School_Co3.SchoolID = qSession_Sales_School_Co2.SchoolID) INNER JOIN Schools ON qSession_Sales_School_Co2.SchoolID = Schools.SchoolID
ORDER BY Schools.School;

