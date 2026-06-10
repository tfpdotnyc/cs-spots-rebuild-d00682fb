-- Query: qPkg_Sales_Employee_Co5
SELECT Users.FirstName, QPkg_Sales_Employee_Co4.[# SSP], QPkg_Sales_Employee_Co4.[$ SSP], QPkg_Sales_Employee_Co4.[# A], QPkg_Sales_Employee_Co4.[$ A], QPkg_Sales_Employee_Co4.[# B], QPkg_Sales_Employee_Co4.[$ B], QPkg_Sales_Employee_Co4.[# C], QPkg_Sales_Employee_Co4.[$ C], QPkg_Sales_Employee_Co4.[# D], QPkg_Sales_Employee_Co4.[$ D], QPkg_Sales_Employee_Co4.[# E], QPkg_Sales_Employee_Co4.[$ E], QPkg_Sales_Employee_Co4.[# F], QPkg_Sales_Employee_Co4.[$ F], QPkg_Sales_Employee_Co4.[# G], QPkg_Sales_Employee_Co4.[$ G]
FROM Users INNER JOIN QPkg_Sales_Employee_Co4 ON Users.UserID = QPkg_Sales_Employee_Co4.UserID
ORDER BY Users.FirstName;

