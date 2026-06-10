-- Query: qSession_Sales_School_Studio2
SELECT Sessions.Studio, IIf([Sessions].[CustomerID]<99999999,Int([Sessions].[CustomerID]/1000)*1000,Int(Val(Mid$(Trim$(Str([Sessions].[CustomerID])),5))/1000)*1000) AS SchoolID, Count(SessionDetail.SessionDetailID) AS Total
FROM Sessions INNER JOIN SessionDetail ON Sessions.SessionID = SessionDetail.SessionID
GROUP BY Sessions.Studio, IIf([Sessions].[CustomerID]<99999999,Int([Sessions].[CustomerID]/1000)*1000,Int(Val(Mid$(Trim$(Str([Sessions].[CustomerID])),5))/1000)*1000);

