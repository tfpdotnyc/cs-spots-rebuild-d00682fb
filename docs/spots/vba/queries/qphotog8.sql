-- Query: qphotog8
SELECT Photographers.FirstName, qphotog1.[# PHOTOD], qphotog2.[# RESITS], qphotog4.[# PACKAGES], qphotog4.[$ PACKAGES], qphotog6.[PACKAGE AVERAGE], qphotog7.[# ACES]
FROM ((((qphotog1 LEFT JOIN qphotog2 ON qphotog1.PhotographerID = qphotog2.ResitID) LEFT JOIN qphotog4 ON qphotog1.PhotographerID = qphotog4.PhotographerID) LEFT JOIN qphotog6 ON qphotog1.PhotographerID = qphotog6.PhotographerID) LEFT JOIN qphotog7 ON qphotog1.PhotographerID = qphotog7.PhotographerID) LEFT JOIN Photographers ON qphotog1.PhotographerID = Photographers.PhotographerID
ORDER BY Photographers.FirstName;

