-- Query: qPkg_Sales_Employee_Studio5
SELECT Studios.Name, Users.FirstName, QPkg_Sales_Employee_Studio4.[# SSP], QPkg_Sales_Employee_Studio4.[$ SSP], QPkg_Sales_Employee_Studio4.[# A], QPkg_Sales_Employee_Studio4.[$ A], QPkg_Sales_Employee_Studio4.[# B], QPkg_Sales_Employee_Studio4.[$ B], QPkg_Sales_Employee_Studio4.[# C], QPkg_Sales_Employee_Studio4.[$ C], QPkg_Sales_Employee_Studio4.[# D], QPkg_Sales_Employee_Studio4.[$ D], QPkg_Sales_Employee_Studio4.[# E], QPkg_Sales_Employee_Studio4.[$ E], QPkg_Sales_Employee_Studio4.[# F], QPkg_Sales_Employee_Studio4.[$ F], QPkg_Sales_Employee_Studio4.[# G], QPkg_Sales_Employee_Studio4.[$ G]
FROM (QPkg_Sales_Employee_Studio4 INNER JOIN Users ON QPkg_Sales_Employee_Studio4.UserID = Users.UserID) INNER JOIN Studios ON QPkg_Sales_Employee_Studio4.Studio = Studios.Studio
ORDER BY Studios.Name, Users.FirstName;

