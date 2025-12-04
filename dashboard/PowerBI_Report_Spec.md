# 📘 Power BI Report Specification

### Revenue Forecasting Under Economic Uncertainty

This document defines the **pages, visuals, KPI logic, DAX measures, filters, and data model** used to build an enterprise-grade Power BI report for forecasting revenue under varying economic conditions.

## 🧱 1. Data Model Overview
**Fact Table**

✔ fact_revenue

- date

- revenue_actual

- revenue_forecast

- revenue_low_case

- revenue_high_case

- units_sold

- product_id

- region_id

**Dimension Tables**

✔ `dim_date` – calendar, month, quarter, YOY keys<br />
✔ `dim_product` – category, segment<br />
✔ `dim_region` – country, region, channel<br />
✔ `dim_economic_indicators` – inflation, interest rate, unemployment, CPI

**Model Relationships**

- fact_revenue (date) → dim_date (date_key) — active

- fact_revenue (product_id) → dim_product

- fact_revenue (region_id) → dim_region

- dim_economic_indicators (date) → dim_date — inactive, activated via DAX

  ## 📄 2. Report Pages & Visual Layout
1️⃣ Revenue Overview (Executive Dashboard)
Purpose:

Provide top-level performance trends, forecast accuracy, and high-level financial signals.

Visuals

| Visual       | Description                                                        |
| ------------ | ------------------------------------------------------------------ |
| KPI Cards    | Total Revenue, Forecasted Revenue, YOY Growth %, Forecast Accuracy |
| Line Chart   | Actual vs Forecast vs Upper/Lower Confidence Intervals             |
| Ribbon Chart | Category-level revenue share over time                             |
| Map          | Revenue by geography                                               |
| Bar Chart    | Top 10 revenue drivers                                             |

Important DAX Measures
```
Total Revenue = SUM(fact_revenue[revenue_actual])

Forecast Revenue = SUM(fact_revenue[revenue_forecast])

YOY Growth % = 
VAR Current = [Total Revenue]
VAR LastYear = CALCULATE([Total Revenue], DATEADD(dim_date[date], -1, YEAR))
RETURN DIVIDE(Current - LastYear, LastYear)

Forecast Accuracy % =
1 - ABS([Total Revenue] - [Forecast Revenue]) / [Total Revenue]
```
2️⃣ Economic Indicator Correlation
Purpose:

Show how macroeconomic trends influence revenue.

Visuals

Scatter plot: Inflation vs Revenue

Line chart: CPI, Interest Rates, Revenue on dual axis

Heatmap: Correlation matrix (Revenue vs macro indicators)

Decomposition tree: Revenue drivers

DAX Measures
```
Inflation Impact =
CALCULATE([Total Revenue], USERELATIONSHIP(dim_economic_indicators[date], dim_date[date]))

Correlation Helper = 
-- exported from Python, imported into Power BI as table for heatmap
```
