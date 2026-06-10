-- Query: qSchoolOrder3
SELECT qSchoolOrder2.School, qSchoolOrder2.OrderCount, qSchoolOrder1.SessionCount, [OrderTotal] AS TotalSales, IIf([SessionCount]=0,0,([OrderTotal])/[SessionCount]) AS SessionAvg, IIf([SessionCount]=0,0,([OrderTotal])/[OrderCount]) AS OrderAvg, IIf([SessionCount]=0,0,([OrderCount]/[SessionCount])*100) AS ReturnPct
FROM qSchoolOrder1 RIGHT JOIN qSchoolOrder2 ON qSchoolOrder1.School = qSchoolOrder2.School;

