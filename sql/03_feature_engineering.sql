/* ============================================
   03 — FEATURE ENGINEERING
   ============================================ */

-- Create lag features
INSERT INTO feature_store (date, revenue, revenue_lag1, revenue_lag3, revenue_lag6, revenue_lag12,
                           revenue_roll3, revenue_roll6, revenue_yoy, revenue_real,
                           cpi, unemployment_rate, gdp_growth, consumer_sentiment)
SELECT
    s.date,
    s.revenue,
    LAG(s.revenue, 1) OVER (ORDER BY s.date)  AS revenue_lag1,
    LAG(s.revenue, 3) OVER (ORDER BY s.date)  AS revenue_lag3,
    LAG(s.revenue, 6) OVER (ORDER BY s.date)  AS revenue_lag6,
    LAG(s.revenue, 12) OVER (ORDER BY s.date) AS revenue_lag12,

    AVG(s.revenue) OVER (ORDER BY s.date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS revenue_roll3,
    AVG(s.revenue) OVER (ORDER BY s.date ROWS BETWEEN 5 PRECEDING AND CURRENT ROW) AS revenue_roll6,

    (s.revenue - LAG(s.revenue, 12) OVER (ORDER BY s.date)) /
     NULLIF(LAG(s.revenue, 12) OVER (ORDER BY s.date), 0) AS revenue_yoy,

    -- inflation adjustment: base CPI = first CPI
    s.revenue / (m.cpi / (SELECT cpi FROM dim_macro ORDER BY date LIMIT 1)) AS revenue_real,

    m.cpi,
    m.unemployment_rate,
    m.gdp_growth,
    m.consumer_sentiment

FROM fact_sales s
JOIN dim_macro m USING (date)
ORDER BY s.date;
