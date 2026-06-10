-- Query: TotalSeniors
PARAMETERS pSchoolNum IEEEDouble;
SELECT COUNT(*)
FROM Customers
WHERE (Customers.CustomerID >= pSchoolNum AND Customers.CustomerID < (pSchoolNum + 1000));

