-- Query: 000PPSessionInfo
SELECT Sessions.CustomerID, Sessions.SessionNumber, Sessions.DateTime, Sessions.UserID, Sessions.TotalDue, SessionDetail.Units, SessionItems.UnitPrice, [Units]*[UnitPrice] AS TotalCharges, SessionItems.Taxable, SessionDetail.Discount, SessionDetail.LineTotal, IIf([Taxable]=True,Round([LineTotal]*[SalesTaxRate],2),0) AS Tax, Round([Units]*[UnitPrice]*[Discount],2) AS DiscountAmt
FROM (SessionDetail INNER JOIN SessionItems ON SessionDetail.SessionItemID = SessionItems.SessionItemID) INNER JOIN Sessions ON SessionDetail.SessionID = Sessions.SessionID;

