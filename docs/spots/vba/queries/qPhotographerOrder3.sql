-- Query: qPhotographerOrder3
SELECT qPhotographerOrder2.Photographer, qPhotographerOrder_TotalPoses.TotalPoses, qPhotographerOrder2.OrderCount, qPhotographerOrder1.SessionCount, qPhotographerOrder2.OrderTotal AS TotalSales, IIf([SessionCount]=0,0,([OrderTotal])/[SessionCount]) AS SessionAvg, IIf([OrderCount]=0,0,([OrderTotal])/[OrderCount]) AS OrderAvg, IIf([SessionCount]=0,0,([OrderCount]/[SessionCount])*100) AS ReturnPct, IIf([OrderCount]=0,0,([TotalPoses])/[OrderCount]) AS PoseAvg
FROM (qPhotographerOrder1 RIGHT JOIN qPhotographerOrder2 ON qPhotographerOrder1.Photographer = qPhotographerOrder2.Photographer) LEFT JOIN qPhotographerOrder_TotalPoses ON qPhotographerOrder2.PhotographerID = qPhotographerOrder_TotalPoses.PhotographerID;

