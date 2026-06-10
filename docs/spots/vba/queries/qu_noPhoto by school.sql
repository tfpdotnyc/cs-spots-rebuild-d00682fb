-- Query: qu_noPhoto by school
SELECT Schools.School, [qu_Cust Without Sess].CustomerID, [qu_Cust Without Sess].LastName, [qu_Cust Without Sess].FirstName, [qu_Cust Without Sess].Address, [qu_Cust Without Sess].City, Schools.Studio, Studios.Name
FROM ([qu_Cust Without Sess] INNER JOIN (CustSchID INNER JOIN Schools ON CustSchID.SchoolID = Schools.SchoolID) ON [qu_Cust Without Sess].CustomerID = CustSchID.CustomerID) INNER JOIN Studios ON Schools.Studio = Studios.Studio
ORDER BY Schools.School, [qu_Cust Without Sess].LastName, [qu_Cust Without Sess].FirstName;

