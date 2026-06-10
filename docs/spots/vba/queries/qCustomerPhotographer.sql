-- Query: qCustomerPhotographer
SELECT Sessions.CustomerID, Photographers.LastName, Photographers.FirstName, Photographers.PhotographerID
FROM Photographers INNER JOIN Sessions ON Photographers.PhotographerID = Sessions.PhotographerID
WHERE (((Sessions.SessionNumber) = 'SA'))
GROUP BY Sessions.CustomerID, Photographers.LastName, Photographers.FirstName, Photographers.PhotographerID;

