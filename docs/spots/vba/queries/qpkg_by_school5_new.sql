-- Query: qpkg_by_school5_new
SELECT qpkg_by_school4_new.SchoolID, Count(qpkg_by_school4_new.CustomerID) AS [# ORDERED]
FROM qpkg_by_school4_new
GROUP BY qpkg_by_school4_new.SchoolID;

