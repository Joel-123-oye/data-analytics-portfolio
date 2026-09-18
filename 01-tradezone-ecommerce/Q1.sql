-- ============================================================
-- Q1: Customer Acquisition & 30-Day Conversion
-- Find top 5 states by new customer sign-ups in 2024
-- and percentage who made a purchase within 30 days
-- ============================================================

SELECT 
  c.state,
  COUNT(DISTINCT c.customer_id) AS new_customers,
  COUNT(DISTINCT o.customer_id) AS converted_customers,
  ROUND(
    COUNT(DISTINCT o.customer_id) * 100.0 / 
    COUNT(DISTINCT c.customer_id), 2
  ) AS conversion_rate_pct
FROM customers c
LEFT JOIN orders o 
  ON c.customer_id = o.customer_id
  AND o.order_date <= c.signup_date + INTERVAL '30 days'
WHERE EXTRACT(YEAR FROM c.signup_date) = 2024
GROUP BY c.state
ORDER BY new_customers DESC
LIMIT 5;