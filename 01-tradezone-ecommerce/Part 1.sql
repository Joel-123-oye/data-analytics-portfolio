-- ============================================================
-- PART 1: DATA CLEANING SCRIPT
-- TradeZone E-Commerce Database
-- HNG14-DA-S2
-- ============================================================

-- STEP 1: Check NULL values in customers
SELECT 
  COUNT(*) FILTER (WHERE email IS NULL) AS null_email,
  COUNT(*) FILTER (WHERE city IS NULL) AS null_city,
  COUNT(*) FILTER (WHERE state IS NULL) AS null_state,
  COUNT(*) FILTER (WHERE signup_date IS NULL) AS null_signup_date
FROM customers;

-- STEP 2: Check NULL values in orders
SELECT
  COUNT(*) FILTER (WHERE total_amount IS NULL) AS null_total_amount
FROM orders;

-- STEP 3: Check duplicates
SELECT customer_id, COUNT(*) FROM customers 
GROUP BY customer_id HAVING COUNT(*) > 1;

SELECT seller_id, COUNT(*) FROM sellers 
GROUP BY seller_id HAVING COUNT(*) > 1;

SELECT order_id, COUNT(*) FROM orders 
GROUP BY order_id HAVING COUNT(*) > 1;

-- STEP 4: Standardise city names
UPDATE customers SET city = INITCAP(TRIM(city));
UPDATE sellers SET city = INITCAP(TRIM(city));

-- Fix specific city inconsistencies
UPDATE customers SET city = 'Lagos' 
WHERE LOWER(TRIM(city)) LIKE '%lago%';

UPDATE customers SET city = 'Port Harcourt' 
WHERE LOWER(TRIM(city)) LIKE '%harcourt%' 
   OR LOWER(TRIM(city)) LIKE '%portharcourt%';

UPDATE sellers SET city = 'Lagos' 
WHERE LOWER(TRIM(city)) LIKE '%lago%';

UPDATE sellers SET city = 'Port Harcourt' 
WHERE LOWER(TRIM(city)) LIKE '%harcourt%'
   OR LOWER(TRIM(city)) LIKE '%portharcourt%';

-- STEP 5: Normalise product categories
UPDATE products SET category = 
  CASE 
    WHEN LOWER(category) LIKE '%beauty%' THEN 'Beauty & Personal Care'
    WHEN LOWER(category) LIKE '%book%' THEN 'Books & Stationery'
    WHEN LOWER(category) LIKE '%electron%' THEN 'Electronics'
    WHEN LOWER(category) LIKE '%fashion%' THEN 'Fashion'
    WHEN LOWER(category) LIKE '%food%' THEN 'Food & Groceries'
    WHEN LOWER(category) LIKE '%health%' THEN 'Health & Wellness'
    WHEN LOWER(category) LIKE '%home%' THEN 'Home & Kitchen'
    WHEN LOWER(category) LIKE '%sport%' THEN 'Sports & Fitness'
    WHEN LOWER(category) LIKE '%toy%' THEN 'Toys & Games'
    ELSE INITCAP(TRIM(category))
  END;

-- STEP 6: Handle missing emails
-- Decision: Set NULL emails to unknown to preserve customer records
UPDATE customers 
SET email = 'unknown@tradezone.com' 
WHERE email IS NULL;

-- STEP 7: Fix missing total_amount using order_items
UPDATE orders o
SET total_amount = (
  SELECT SUM(line_total) 
  FROM order_items oi 
  WHERE oi.order_id = o.order_id
)
WHERE total_amount IS NULL;

-- STEP 8: Flag amount mismatches > 10
ALTER TABLE orders ADD COLUMN IF NOT EXISTS amount_flag VARCHAR(50);

UPDATE orders o
SET amount_flag = 'AMOUNT_MISMATCH'
WHERE ABS(o.total_amount - (
  SELECT SUM(line_total) 
  FROM order_items oi 
  WHERE oi.order_id = o.order_id
)) > 10;

-- STEP 9: Validate review ratings
SELECT COUNT(*) AS invalid_ratings
FROM reviews WHERE rating < 1 OR rating > 5;

-- STEP 10: Check negative prices
SELECT COUNT(*) AS negative_prices
FROM products WHERE unit_price < 0;