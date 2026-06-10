-- Query: qPhotographerOrder0
SELECT qSessionReport1.PhotographerID, Count(qSessionReport1.SessionID) AS SessionCount
FROM qSessionReport1 LEFT JOIN ResitReasons ON qSessionReport1.ResitID = ResitReasons.ResitID
WHERE (((qSessionReport1.DateTime) >= #5/13/2001# And (qSessionReport1.DateTime) <= #5/13/2003#) And ((ResitReasons.Charge) = True Or (ResitReasons.Charge) Is Null) And ((qSessionReport1.SessionNumber) = 'SA'))
GROUP BY qSessionReport1.PhotographerID;

