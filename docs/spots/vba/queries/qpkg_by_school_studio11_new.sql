-- Query: qpkg_by_school_studio11_new
SELECT Studios.Name AS Studio, qpkg_by_school_studio10_new.School, qpkg_by_school_studio10_new.[# SENIORS], qpkg_by_school_studio10_new.[# PHOTOD], qpkg_by_school_studio10_new.[# ORDERED], qpkg_by_school_studio10_new.[TOTAL SALES], qpkg_by_school_studio10_new.[DEP  PAID], qpkg_by_school_studio10_new.[AVG ORDER]
FROM qpkg_by_school_studio10_new INNER JOIN Studios ON qpkg_by_school_studio10_new.Studio = Studios.Studio
ORDER BY Studios.Name, qpkg_by_school_studio10_new.School;

