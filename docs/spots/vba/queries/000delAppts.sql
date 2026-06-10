-- Query: 000delAppts
DELETE Appointments.*
FROM 000delCust INNER JOIN Appointments ON [000delCust].CustomerID = Appointments.CustomerID;

