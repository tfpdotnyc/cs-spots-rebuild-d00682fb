-- Query: qpkg_by_school9_new
SELECT qpkg_by_school8_new.SchoolID, Avg(qpkg_by_school8_new.SumOfLineTotal) AS [AVG ORDER]
FROM qpkg_by_school8_new
GROUP BY qpkg_by_school8_new.SchoolID;

