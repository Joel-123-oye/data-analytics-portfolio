-- ============================================================
-- Q4: Quarterly Revenue Trends
-- Compare quarterly revenue across 2023 and 2024
-- Includes total revenue, average order value and order count
-- Identifies strongest revenue growth quarter
-- ============================================================

SELECT
  EXTRACT(YEAR FROM order_date) AS year,
  EXTRACT(QUARTER FROM order_date) AS quarter,
  ROUND(SUM(total_amount)::NUMERIC, 2) AS total_revenue,
  ROUND(AVG(total_amount)::NUMERIC, 2) AS avg_order_value,
  COUNT(order_id) AS total_orders
FROM orders
WHERE order_status != 'Cancelled'
  AND total_amount IS NOT NULL
GROUP BY year, quarter
ORDER BY year, quarter;