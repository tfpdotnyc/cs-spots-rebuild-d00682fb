-- Query: TotalOrders
PARAMETERS pSchoolNum IEEEDouble;
SELECT COUNT(*)
FROM Orders
WHERE (Orders.CustomerID >= pSchoolNum AND Orders.CustomerID < (pSchoolNum + 1000));

