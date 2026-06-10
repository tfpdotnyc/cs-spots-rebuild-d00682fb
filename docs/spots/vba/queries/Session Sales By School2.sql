-- Query: Session Sales By School2
SELECT Schools.School, SessionItems.Description, Sessions.DateTime, Count(SessionDetail.Units) AS Units
FROM (((SessionDetail INNER JOIN Sessions ON SessionDetail.SessionID = Sessions.SessionID) INNER JOIN Customers ON Sessions.CustomerID = Customers.CustomerID) INNER JOIN Schools ON Customers.SchoolID = Schools.SchoolID) INNER JOIN SessionItems ON SessionDetail.SessionItemID = SessionItems.SessionItemID
GROUP BY Schools.School, SessionItems.Description, Sessions.DateTime
UNION SELECT Schools.School, ' TOTAL SESSIONS' AS Expr1, Sessions.DateTime, Count(Sessions.DateTime) AS CountOfOrderDate
FROM (Sessions  INNER JOIN Customers ON Sessions.CustomerID = Customers.CustomerID) INNER JOIN Schools ON Customers.SchoolID = Schools.SchoolID
GROUP BY Schools.School, Sessions.DateTime;

