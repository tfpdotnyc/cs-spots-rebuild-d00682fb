-- Query: qOrderTax
SELECT qOrderTaxDetail.OrderID, Sum(qOrderTaxDetail.Tax) AS TotalTax
FROM qOrderTaxDetail
GROUP BY qOrderTaxDetail.OrderID;

