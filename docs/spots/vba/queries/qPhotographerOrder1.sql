-- Query: qPhotographerOrder1
SELECT [Photographers].[FirstName] & ' ' & [Photographers].[LastName] AS Photographer, qPhotographerOrder0.SessionCount, Sum(SessionDetail.LineTotal) AS SessionSales
FROM (((qSessionReport2 INNER JOIN SessionDetail ON qSessionReport2.SessionID = SessionDetail.SessionID) INNER JOIN Photographers ON qSessionReport2.PhotographerID = Photographers.PhotographerID) LEFT JOIN ResitReasons ON qSessionReport2.ResitID = ResitReasons.ResitID) INNER JOIN qPhotographerOrder0 ON qSessionReport2.PhotographerID = qPhotographerOrder0.PhotographerID
WHERE (((qSessionReport2.DateTime)>=#5/13/2001# And (qSessionReport2.DateTime)<=#5/13/2003#) AND ((ResitReasons.Charge)=True Or (ResitReasons.Charge) Is Null) AND ((qSessionReport2.SessionNumber)='SA'))
GROUP BY [Photographers].[FirstName] & ' ' & [Photographers].[LastName], qPhotographerOrder0.SessionCount;

