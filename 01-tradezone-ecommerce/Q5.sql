-- ============================================================
-- Q5: Customer Spend Segmentation
-- Segments customers by total spend in 2024 into:
-- High Spenders: >= 100,000
-- Medium Spenders: 50,000 - 99,999
-- Low Spenders: < 50,000
-- Includes customer count, avg spend and total revenue
-- ============================================================

WITH customer_spend AS (
  SELECT
    customer_id,
    SUM(total_amount) AS total_spend
  FROM orders
  WHERE EXTRACT(YEAR FROM order_date) = 2024
    AND total_amount IS NOT NULL
  GROUP BY customer_id
)
SELECT
  CASE
    WHEN total_spend >= 100000 THEN 'High Spenders'
    WHEN total_spend >= 50000 THEN 'Medium Spenders'
    ELSE 'Low Spenders'
  END AS spend_segment,
  COUNT(*) AS customer_count,
  ROUND(AVG(total_spend)::NUMERIC, 2) AS avg_spend_per_customer,
  ROUND(SUM(total_spend)::NUMERIC, 2) AS total_revenue_contribution
FROM customer_spend
GROUP BY spend_segment
ORDER BY total_revenue_contribution DESC;