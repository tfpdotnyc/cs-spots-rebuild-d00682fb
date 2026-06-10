-- Query: qYBOMiss1
SELECT Customers.CustomerID, Customers.LastName, Customers.FirstName, Customers.Phone, Customers.Photographed, Customers.SchoolID, IIf([Customers].[CustomerID]<99999999,IIf([Customers].[CustomerID]>=100000 And [Customers].[CustomerID]<=999999,Int([Customers].[CustomerID]/10000)*10000,Int([Customers].[CustomerID]/1000)*1000),Int(Val(Mid([Customers].[CustomerID],5))/1000)*1000) AS SchoolIdOld, Sessions.SessionNumber, Sessions.YBO
FROM Customers INNER JOIN Sessions ON Customers.CustomerID = Sessions.CustomerID;

