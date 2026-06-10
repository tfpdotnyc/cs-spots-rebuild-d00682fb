-- Query: QPkg_Sales_Employee_Co4
SELECT qPkg_Sales_Employee_Co2.UserID, qPkg_Sales_Employee_Co2.A AS [# A], qPkg_Sales_Employee_Co3.A AS [$ A], qPkg_Sales_Employee_Co2.B AS [# B], qPkg_Sales_Employee_Co3.B AS [$ B], qPkg_Sales_Employee_Co2.C AS [# C], qPkg_Sales_Employee_Co3.C AS [$ C], qPkg_Sales_Employee_Co2.D AS [# D], qPkg_Sales_Employee_Co3.D AS [$ D], qPkg_Sales_Employee_Co2.E AS [# E], qPkg_Sales_Employee_Co3.E AS [$ E], qPkg_Sales_Employee_Co2.F AS [# F], qPkg_Sales_Employee_Co3.F AS [$ F], qPkg_Sales_Employee_Co2.G AS [# G], qPkg_Sales_Employee_Co3.G AS [$ G], qPkg_Sales_Employee_Co2.SSP AS [# SSP], qPkg_Sales_Employee_Co3.SSP AS [$ SSP]
FROM qPkg_Sales_Employee_Co2 INNER JOIN qPkg_Sales_Employee_Co3 ON qPkg_Sales_Employee_Co2.UserID = qPkg_Sales_Employee_Co3.UserID;

