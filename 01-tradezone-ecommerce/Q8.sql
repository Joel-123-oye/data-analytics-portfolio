-- ============================================================
-- Q8: Top Seller Bonus Qualification
-- Top 10 sellers in 2024 by total revenue
-- Must have at least 10 completed orders
-- Must have average customer rating of 4.0 or above
-- Includes total orders, average rating and total revenue
-- ============================================================

SELECT
  s.seller_id,
  s.seller_name,
  COUNT(DISTINCT o.order_id) AS total_orders,
  ROUND(AVG(r.rating)::NUMERIC, 2) AS avg_rating,
  ROUND(SUM(o.total_amount)::NUMERIC, 2) AS total_revenue
FROM sellers s
JOIN orders o ON s.seller_id = o.seller_id
LEFT JOIN reviews r ON o.order_id = r.order_id
WHERE EXTRACT(YEAR FROM o.order_date) = 2024
  AND o.total_amount IS NOT NULL
GROUP BY s.seller_id, s.seller_name
HAVING COUNT(DISTINCT o.order_id) >= 10
  AND AVG(r.rating) >= 4.0
ORDER BY total_revenue DESC
LIMIT 10;