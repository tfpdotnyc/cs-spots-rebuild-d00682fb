-- Query: qhotlist3
SELECT qhotlist2.Action, qhotlist2.Description, Customers.LastName, Customers.FirstName, Orders.CustomerID, Orders.OrderNumber, Customers.SchoolID, IIf([Customers].[CustomerID]<99999999,Int([Customers].[CustomerID]/1000)*1000,Int(Val(Mid$(Trim$(Str([Customers].[CustomerID])),5))/1000)*1000) AS SchoolIDOld, qhotlist2.Date, qhotlist2.Days, qhotlist2.CDate, Orders.OrderID
FROM (qhotlist2 INNER JOIN Orders ON qhotlist2.OrderID = Orders.OrderID) INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

