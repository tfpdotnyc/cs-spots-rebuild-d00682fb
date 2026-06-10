-- Query: qpkg_by_school3_new
SELECT qpkg_by_school2_new.SchoolID, Count(qpkg_by_school2_new.CustomerID) AS [# PHOTOD]
FROM qpkg_by_school2_new
GROUP BY qpkg_by_school2_new.SchoolID;

