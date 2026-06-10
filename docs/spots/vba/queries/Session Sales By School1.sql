-- Query: Session Sales By School1
SELECT Schools.School, SessionItems.Description, Sessions.DateTime, Count(SessionDetail.Units) AS Units
FROM (((SessionDetail INNER JOIN Sessions ON SessionDetail.SessionID = Sessions.SessionID) INNER JOIN Customers ON Sessions.CustomerID = Customers.CustomerID) INNER JOIN Schools ON Customers.SchoolID = Schools.SchoolID) INNER JOIN SessionItems ON SessionDetail.SessionItemID = SessionItems.SessionItemID
GROUP BY Schools.School, SessionItems.Description, Sessions.DateTime;

