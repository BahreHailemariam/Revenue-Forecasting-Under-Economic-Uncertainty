/* ============================================
   02 — DATA CLEANING
   ============================================ */

-- Fix negative revenue values
UPDATE fact_sales
SET revenue = NULL
WHERE revenue < 0;

-- Replace NULL revenues with median
UPDATE fact_sales fs
SET revenue = sub.median_value
FROM (
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY revenue) AS median_value
    FROM fact_sales
) sub
WHERE fs.revenue IS NULL;

-- Standardize channel names
UPDATE fact_sales
SET channel = LOWER(channel);

-- Fix macroeconomic nulls using LOCF (last observed value)
UPDATE dim_macro m
SET cpi = sub.prev_val
FROM (
    SELECT date, 
           LAST_VALUE(cpi IGNORE NULLS) OVER (ORDER BY date) AS prev_val
    FROM dim_macro
) sub
WHERE m.date = sub.date AND m.cpi IS NULL;

-- Ensure date consistency in both tables
DELETE FROM dim_macro
WHERE date NOT IN (SELECT date FROM fact_sales);
