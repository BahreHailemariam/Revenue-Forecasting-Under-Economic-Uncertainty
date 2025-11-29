/* ============================================
   04 — KPI METRICS
   ============================================ */

-- Month-over-month revenue growth
CREATE OR REPLACE VIEW kpi_revenue_mom AS
SELECT
    date,
    revenue,
    (revenue - LAG(revenue) OVER (ORDER BY date)) /
     NULLIF(LAG(revenue) OVER (ORDER BY date), 0) AS mom_growth
FROM fact_sales;

-- Quartely revenue volatility (standard deviation)
CREATE OR REPLACE VIEW kpi_revenue_volatility AS
SELECT
    date,
    STDDEV(revenue) OVER (ORDER BY date ROWS BETWEEN 11 PRECEDING AND CURRENT ROW)
        AS revenue_volatility
FROM fact_sales;

-- Correlation between revenue and economic indicators
CREATE OR REPLACE VIEW kpi_macro_correlation AS
SELECT
    CORR(revenue, cpi)                AS corr_revenue_cpi,
    CORR(revenue, unemployment_rate)  AS corr_revenue_unemployment,
    CORR(revenue, gdp_growth)         AS corr_revenue_gdp,
    CORR(revenue, consumer_sentiment) AS corr_revenue_sentiment
FROM feature_store;

-- Revenue at risk (RAR) using volatility bands
CREATE OR REPLACE VIEW kpi_revenue_at_risk AS
SELECT
    f.date,
    f.revenue,
    (f.revenue - (2 * v.revenue_volatility)) AS downside_risk,
    (f.revenue + (2 * v.revenue_volatility)) AS upside_opportunity
FROM fact_sales f
JOIN kpi_revenue_volatility v USING(date);
