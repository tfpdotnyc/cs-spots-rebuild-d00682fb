-- Query: qCustList1
SELECT Customers.SchoolID, IIf([Customers].[CustomerID]<99999999,Int([Customers].[CustomerID]/1000)*1000,Int(Val(Mid$(Trim$(Str([Customers].[CustomerID])),5))/1000)*1000) AS SchoolIDOld, Customers.LastName, Customers.FirstName, Customers.CustomerID, Orders.OrderNumber, Orders.OrderDate
FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

