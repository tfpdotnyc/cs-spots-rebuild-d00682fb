-- Query: qStudioOrder1
SELECT Studios.Name, Count(qSessionReport2.SessionID) AS SessionCount, Sum(SessionDetail.LineTotal) AS SessionSales
FROM ((qSessionReport2 INNER JOIN SessionDetail ON qSessionReport2.SessionID = SessionDetail.SessionID) INNER JOIN Studios ON qSessionReport2.Studio = Studios.Studio) LEFT JOIN ResitReasons ON qSessionReport2.ResitID = ResitReasons.ResitID
WHERE (((qSessionReport2.DateTime) >= #3/24/2002# And (qSessionReport2.DateTime) <= #3/24/2003#) And ((ResitReasons.Charge) = True Or (ResitReasons.Charge) Is Null))
GROUP BY Studios.Name;

