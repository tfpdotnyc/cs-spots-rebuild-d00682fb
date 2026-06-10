-- Query: qStudioOrder3
SELECT qStudioOrder1.Name, qStudioOrder2.OrderCount, qStudioOrder1.SessionCount, [OrderTotal] AS TotalSales, IIf([SessionCount]=0,0,([OrderTotal])/[SessionCount]) AS SessionAvg, IIf([SessionCount]=0,0,([OrderTotal])/[OrderCount]) AS OrderAvg, IIf([SessionCount]=0,0,([OrderCount]/[SessionCount])*100) AS ReturnPct
FROM qStudioOrder1 INNER JOIN qStudioOrder2 ON qStudioOrder1.Name = qStudioOrder2.Name;

