-- Query: qSession_Sales_Employee_Studio4
SELECT Studios.Name AS Studio, Users.FirstName, qSession_Sales_Employee_Studio3.[Basic Session] AS Expr1, Format([Basic Session]/[Total],"Percent") AS [% Basic Session], qSession_Sales_Employee_Studio3.[Graduate Session] AS Expr2, Format([Graduate Session]/[Total],"Percent") AS [% Graduate Session], qSession_Sales_Employee_Studio3.[Senior Session] AS Expr3, Format([Senior Session]/[Total],"Percent") AS [% Senior Session], qSession_Sales_Employee_Studio2.Total, 0 AS [1999 Session], 0 AS [% 1999 Session]
FROM ((qSession_Sales_Employee_Studio3 INNER JOIN qSession_Sales_Employee_Studio2 ON (qSession_Sales_Employee_Studio3.Studio = qSession_Sales_Employee_Studio2.Studio) AND (qSession_Sales_Employee_Studio3.UserID = qSession_Sales_Employee_Studio2.UserID)) INNER JOIN Users ON qSession_Sales_Employee_Studio2.UserID = Users.UserID) INNER JOIN Studios ON qSession_Sales_Employee_Studio2.Studio = Studios.Studio
ORDER BY Studios.Name, Users.FirstName;

