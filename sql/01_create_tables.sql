/* ============================================
   01 — CREATE TABLES
   Revenue Forecasting Under Economic Uncertainty
   ============================================ */

-- =====================
-- SALES FACT TABLE
-- =====================
CREATE TABLE fact_sales (
    date             DATE PRIMARY KEY,
    revenue          NUMERIC(18,2),
    units_sold       NUMERIC(18,2),
    channel          VARCHAR(50)
);

-- =====================
-- MACROECONOMIC FACTORS
-- =====================
CREATE TABLE dim_macro (
    date               DATE PRIMARY KEY,
    cpi                NUMERIC(10,4),
    unemployment_rate  NUMERIC(10,4),
    gdp_growth         NUMERIC(10,4),
    consumer_sentiment NUMERIC(10,4)
);

-- =====================
-- FEATURE STORE TABLE
-- =====================
CREATE TABLE feature_store (
    date                  DATE PRIMARY KEY,
    revenue               NUMERIC(18,2),
    revenue_lag1          NUMERIC(18,2),
    revenue_lag3          NUMERIC(18,2),
    revenue_lag6          NUMERIC(18,2),
    revenue_lag12         NUMERIC(18,2),
    revenue_roll3         NUMERIC(18,2),
    revenue_roll6         NUMERIC(18,2),
    revenue_yoy           NUMERIC(18,6),
    revenue_real          NUMERIC(18,2),
    cpi                   NUMERIC(10,4),
    unemployment_rate     NUMERIC(10,4),
    gdp_growth            NUMERIC(10,4),
    consumer_sentiment    NUMERIC(10,4)
);

-- =====================
-- FORECAST TABLE
-- =====================
CREATE TABLE forecast_output (
    date                 DATE,
    scenario             VARCHAR(20),
    forecast_value       NUMERIC(18,2),
    model_version        VARCHAR(20),
    generated_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
