-- ============================================================
-- Q3: Seller Fulfilment Efficiency
-- Top 20 sellers with fastest average fulfilment times
-- Only sellers with at least 20 completed orders
-- Includes total completed orders and average customer rating
-- ============================================================

SELECT 
  s.seller_id,
  s.seller_name,
  COUNT(o.order_id) AS total_completed_orders,
  ROUND(AVG(EXTRACT(EPOCH FROM (o.delivery_date::timestamp - 
    o.order_date::timestamp))/3600)::NUMERIC, 2) AS avg_fulfilment_hours,
  ROUND(AVG(r.rating)::NUMERIC, 2) AS avg_customer_rating
FROM sellers s
JOIN orders o ON s.seller_id = o.seller_id
LEFT JOIN reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'Delivered'
GROUP BY s.seller_id, s.seller_name
HAVING COUNT(o.order_id) >= 20
ORDER BY avg_fulfilment_hours ASC
LIMIT 20;