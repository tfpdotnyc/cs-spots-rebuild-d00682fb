-- Query: qPkg_Sales_Employee_Co2
TRANSFORM Sum(qPkg_Sales_Employee_Co1.Count) AS SumOfCount
SELECT qPkg_Sales_Employee_Co1.UserID
FROM qPkg_Sales_Employee_Co1
GROUP BY qPkg_Sales_Employee_Co1.UserID
PIVOT qPkg_Sales_Employee_Co1.PkgType;

