-- ============================================================
-- TASK B: PALLADIUM BANK STAR SCHEMA
-- HNG14-DA-S3
-- ============================================================

-- Table 1: Date Dimension
CREATE TABLE dim_date (
  date_key        SERIAL PRIMARY KEY,
  full_date       DATE NOT NULL,
  day_of_week     VARCHAR(10),
  day_of_month    INTEGER,
  month_number    INTEGER,
  month_name      VARCHAR(10),
  quarter         INTEGER,
  year            INTEGER,
  is_weekend      BOOLEAN
);

-- Table 2: Customer Dimension
CREATE TABLE dim_customer (
  customer_key    SERIAL PRIMARY KEY,
  customer_id     VARCHAR(10) NOT NULL,
  customer_name   VARCHAR(100),
  tier            VARCHAR(20),
  is_current      BOOLEAN DEFAULT TRUE,
  effective_date  DATE,
  expiry_date     DATE
);

-- Table 3: Branch Dimension
CREATE TABLE dim_branch (
  branch_key      SERIAL PRIMARY KEY,
  branch_id       VARCHAR(10) NOT NULL,
  branch_name     VARCHAR(100),
  state           VARCHAR(50),
  region          VARCHAR(50)
);

-- Table 4: Product Dimension
CREATE TABLE dim_product (
  product_key     SERIAL PRIMARY KEY,
  product_id      VARCHAR(10) NOT NULL,
  product_name    VARCHAR(100),
  product_type    VARCHAR(50)
);

-- Table 5: Channel Dimension
CREATE TABLE dim_channel (
  channel_key     SERIAL PRIMARY KEY,
  channel_name    VARCHAR(50) NOT NULL,
  channel_type    VARCHAR(50)
);

-- Table 6: Fact Table
CREATE TABLE fact_transactions (
  transaction_key   SERIAL PRIMARY KEY,
  txn_id            VARCHAR(20) NOT NULL,
  date_key          INTEGER REFERENCES dim_date(date_key),
  customer_key      INTEGER REFERENCES dim_customer(customer_key),
  branch_key        INTEGER REFERENCES dim_branch(branch_key),
  product_key       INTEGER REFERENCES dim_product(product_key),
  channel_key       INTEGER REFERENCES dim_channel(channel_key),
  txn_type          VARCHAR(50),
  amount            NUMERIC(18,2),
  balance_after     NUMERIC(18,2)
);

-- Indexes for performance
CREATE INDEX idx_fact_date 
  ON fact_transactions(date_key);
CREATE INDEX idx_fact_customer 
  ON fact_transactions(customer_key);
CREATE INDEX idx_fact_branch 
  ON fact_transactions(branch_key);
CREATE INDEX idx_fact_product 
  ON fact_transactions(product_key);

-- Aggregation Table
CREATE TABLE agg_monthly_branch_revenue (
  agg_key         SERIAL PRIMARY KEY,
  year            INTEGER,
  month_number    INTEGER,
  branch_key      INTEGER REFERENCES dim_branch(branch_key),
  total_amount    NUMERIC(18,2),
  txn_count       INTEGER
);