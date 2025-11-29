/* ============================================
   05 — POWER BI REPORT VIEWS
   ============================================ */

-- Main unified dataset for BI
CREATE OR REPLACE VIEW vw_forecasting_dataset AS
SELECT
    fs.date,
    fs.revenue,
    fs.revenue_real,
    fs.revenue_lag1,
    fs.revenue_lag3,
    fs.revenue_lag6,
    fs.revenue_lag12,
    fs.revenue_roll3,
    fs.revenue_roll6,
    fs.revenue_yoy,
    fs.cpi,
    fs.unemployment_rate,
    fs.gdp_growth,
    fs.consumer_sentiment,
    fm.forecast_value,
    fm.scenario
FROM feature_store fs
LEFT JOIN forecast_output fm ON fs.date = fm.date;

-- Scenario overview
CREATE OR REPLACE VIEW vw_scenario_comparison AS
SELECT
    fm.date,
    fm.scenario,
    fm.forecast_value,
    fs.revenue AS actual_revenue,
    (fm.forecast_value - fs.revenue) AS forecast_error
FROM forecast_output fm
JOIN feature_store fs USING(date)
ORDER BY fm.date;

-- Economic drivers attribution
CREATE OR REPLACE VIEW vw_economic_drivers AS
SELECT
    date,
    revenue,
    cpi,
    unemployment_rate,
    gdp_growth,
    consumer_sentiment,
    revenue_yoy,
    revenue_lag12
FROM feature_store;

-- Executive Dashboard View
CREATE OR REPLACE VIEW vw_executive_summary AS
SELECT
    f.date,
    f.revenue,
    k.mom_growth,
    v.revenue_volatility,
    f.revenue_real,
    f.revenue_yoy
FROM feature_store f
JOIN kpi_revenue_mom k USING(date)
JOIN kpi_revenue_volatility v USING(date)
ORDER BY f.date;
