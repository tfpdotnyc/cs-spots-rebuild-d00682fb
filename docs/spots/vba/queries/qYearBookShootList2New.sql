-- Query: qYearBookShootList2New
SELECT Customers.CustomerID, Customers.LastName, Customers.FirstName, Sessions.SessionNumber, Sessions.DateTime, Sessions.Roll, qYearBookShootList1.MatchDate, Customers.SchoolID, IIf([Customers].[CustomerID]<99999999,IIf([Customers].[CustomerID]>100000,Int([Customers].[CustomerID]/10000)*10000,Int([Customers].[CustomerID]/1000)*1000),Int(Val(Mid$(Trim$(Str([Customers].[CustomerID])),5))/1000)*1000) AS SchoolIDOld, qYearbookShootList_YBPose.PoseNo, qYearbookShootList_YBPose.OrderYB
FROM ((Customers LEFT JOIN Sessions ON Customers.CustomerID = Sessions.CustomerID) LEFT JOIN qYearBookShootList1 ON Customers.CustomerID = qYearBookShootList1.CustomerID) LEFT JOIN qYearbookShootList_YBPose ON Customers.CustomerID = qYearbookShootList_YBPose.CustomerID
WHERE (((Customers.CustomerID)<99999999));

