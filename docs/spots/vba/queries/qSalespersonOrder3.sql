-- Query: qSalespersonOrder3
SELECT Users.FirstName, qSalespersonOrder1.OCount, qSalespersonOrder1.OTotal, qSalespersonOrder2.PCount
FROM (qSalespersonOrder1 LEFT JOIN qSalespersonOrder2 ON qSalespersonOrder1.UserID = qSalespersonOrder2.UserID) INNER JOIN Users ON qSalespersonOrder1.UserID = Users.UserID;

