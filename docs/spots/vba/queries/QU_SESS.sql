-- Query: QU_SESS
SELECT Sessions.SessionID, Sessions.CustomerID
FROM [9-30Trk] INNER JOIN Sessions ON [9-30Trk].CustomerID = Sessions.CustomerID;

