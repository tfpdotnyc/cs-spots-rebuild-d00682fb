-- Query: qSession_Sales_Employee_Co4
SELECT Users.FirstName, qSession_Sales_Employee_Co3.[Basic Session] AS Expr1, Format([Basic Session]/[Total],"Percent") AS [% Basic Session], qSession_Sales_Employee_Co3.[Graduate Session] AS Expr2, Format([Graduate Session]/[Total],"Percent") AS [% Graduate Session], qSession_Sales_Employee_Co3.[Senior Session] AS Expr3, Format([Senior Session]/[Total],"Percent") AS [% Senior Session], qSession_Sales_Employee_Co2.Total, 0 AS [1999 Session], 0 AS [% 1999 Session]
FROM (qSession_Sales_Employee_Co3 INNER JOIN qSession_Sales_Employee_Co2 ON qSession_Sales_Employee_Co3.UserID = qSession_Sales_Employee_Co2.UserID) INNER JOIN Users ON qSession_Sales_Employee_Co2.UserID = Users.UserID
ORDER BY Users.FirstName;

