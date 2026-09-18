-- ============================================================
-- Q7: Review Ratings and Sales Performance
-- Groups products by average review rating into:
-- High Rated: 4.0 and above
-- Mid Rated: 3.0 - 3.99
-- Low Rated: Below 3.0
-- Includes product count, total revenue and avg unit price
-- ============================================================

WITH product_ratings AS (
  SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.unit_price,
    AVG(r.rating) AS avg_rating,
    SUM(oi.line_total) AS total_revenue
  FROM products p
  LEFT JOIN reviews r ON p.product_id = r.product_id
  LEFT JOIN order_items oi ON p.product_id = oi.product_id
  GROUP BY p.product_id, p.product_name, p.category, p.unit_price
)
SELECT
  CASE
    WHEN avg_rating >= 4.0 THEN 'High Rated'
    WHEN avg_rating >= 3.0 THEN 'Mid Rated'
    ELSE 'Low Rated'
  END AS rating_category,
  COUNT(*) AS product_count,
  ROUND(SUM(total_revenue)::NUMERIC, 2) AS total_revenue,
  ROUND(AVG(unit_price)::NUMERIC, 2) AS avg_unit_price
FROM product_ratings
GROUP BY rating_category
ORDER BY total_revenue DESC;