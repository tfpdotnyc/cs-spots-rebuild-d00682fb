-- Query: qYBO3Test
SELECT Schools.School, qYBO1.CustomerID, qYBO1.LastName, qYBO1.FirstName, qYBO1.Phone
FROM (qYBO2 INNER JOIN qYBO1 ON qYBO2.CustomerID = qYBO1.CustomerID) INNER JOIN Schools ON qYBO1.SchoolId = Schools.SchoolID;

