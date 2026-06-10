-- Query: PhotodButNoOrder
PARAMETERS pSchoolNum IEEEDouble;
SELECT COUNT(*)
FROM Sessions
WHERE (((Sessions.CustomerID)>=[pSchoolNum] And (Sessions.CustomerID)<([pSchoolNum]+1000) And (Sessions.CustomerID) Not In (SELECT CustomerID FROM Orders 
   WHERE (Orders.CustomerID >= pSchoolNum AND Orders.CustomerID < (pSchoolNum + 1000)))));

