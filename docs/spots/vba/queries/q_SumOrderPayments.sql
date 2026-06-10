-- Query: q_SumOrderPayments
PARAMETERS pOrderID Long;
SELECT Sum(Amount+AdditionalCash) AS PreviousPayments
FROM OrderPayments
WHERE (((OrderPayments.OrderID)=[pOrderID]));

