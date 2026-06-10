-- Query: q_SessionInformation
PARAMETERS pCustomerID Long, pSessionNumber Text ( 255 );
SELECT Sessions.DateTime, Sessions.UserID, Sessions.PhotographerID, Sessions.ResitID, Sessions.Studio, Sessions.CallWhenReady, Sessions.Rush, Sessions.YearbookFee, Sessions.Payments, Sessions.SessionID
FROM Sessions
WHERE (((Sessions.CustomerID)=[pCustomerID]) AND ((Sessions.SessionNumber)=[pSessionNumber]));

