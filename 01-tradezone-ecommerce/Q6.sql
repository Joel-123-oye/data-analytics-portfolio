-- ============================================================
-- Q6: Payment Method Preferences by State
-- Shows transaction count and total amount for each 
-- payment method per state
-- Identifies most popular payment method per state
-- ============================================================

SELECT
  c.state,
  p.payment_method,
  COUNT(*) AS transaction_count,
  ROUND(SUM(p.amount)::NUMERIC, 2) AS total_amount
FROM payments p
JOIN orders o ON p.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.state, p.payment_method
ORDER BY c.state, transaction_count DESC;