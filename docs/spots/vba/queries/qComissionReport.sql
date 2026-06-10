-- Query: qComissionReport
SELECT qComissionReport_Union.NameSort, IIf([FirstName]='TOTALS',[FirstName],[FirstName] & ' ' & [LastName]) AS FullName, qComissionReport_Union.FirstName, qComissionReport_Union.LastName, IIf([qComissionReport_Union].[NameSort]=2,[qCommissionReport_OrdersTaken_Total].[OrdersTaken],[qComissionReport_Union].[OrdersTaken]) AS TakenOrders, qComissionReport_Union.LineSort, qComissionReport_Union.LineItem, qComissionReport_Union.ItemType, qComissionReport_Union.CountOfOrderID
FROM qComissionReport_Union LEFT JOIN qCommissionReport_OrdersTaken_Total ON qComissionReport_Union.NameSort = qCommissionReport_OrdersTaken_Total.NameSort;

