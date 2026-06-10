-- Query: TotalSeniorsPhotod
PARAMETERS pSchoolNum IEEEDouble;
SELECT DISTINCT CustomerID
FROM Sessions
WHERE (Sessions.CustomerID >= pSchoolNum AND Sessions.CustomerID < (pSchoolNum + 1000));

