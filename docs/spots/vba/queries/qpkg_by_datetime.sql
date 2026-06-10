-- Query: qpkg_by_datetime
SELECT Sessions.DateTime, IIf([Sessions].[CustomerID]<99999999,Int([Sessions].[CustomerID]/1000)*1000,Int(Val(Mid$(Trim$(Str([Sessions].[CustomerID])),5))/1000)*1000) AS SchoolIDOld, Customers.SchoolID, Sessions.CustomerID
FROM Sessions INNER JOIN Customers ON Sessions.CustomerID = Customers.CustomerID
WHERE (((Sessions.CustomerID) < 99999999))
GROUP BY Sessions.DateTime, IIf([Sessions].[CustomerID]<99999999,Int([Sessions].[CustomerID]/1000)*1000,Int(Val(Mid$(Trim$(Str([Sessions].[CustomerID])),5))/1000)*1000), Customers.SchoolID, Sessions.CustomerID;

