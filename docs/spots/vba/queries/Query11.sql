-- Query: Query11
SELECT 0 AS ItremCount, IIf([Actions].[Action]=5 Or [Actions].[Action]=6,[Description] & ' - ' & [RetName],[Description]) AS Status, Actions.Date, Trim(Users.FirstName)+' '+Users.LastName AS ProcessedBy, Studios.Name AS Location, Retouchers.Name AS RetName, Actions.Action, IIf([Actions].[Action]=16,[Shipping].[TrackNo],'') AS TrackNo
FROM ((((Actions LEFT JOIN ActionItems ON Actions.Action = ActionItems.Action) LEFT JOIN Studios ON Actions.Studio = Studios.Studio) LEFT JOIN Users ON Actions.UserID = Users.UserID) LEFT JOIN Retouchers ON Actions.ExtraID = Retouchers.Retoucher) LEFT JOIN Shipping ON Actions.OrderID = Shipping.OrderID
WHERE (((Actions.OrderID)=28000102))
ORDER BY Actions.Date, Actions.ActionID;

