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
Filters

Economic indicator slicer

Region

Product category

3️⃣ Forecast Models Comparison
Purpose:

Compare Prophet, ARIMA, and XGBoost predictions directly.

Visuals

Multi-line comparison chart (Actual vs Prophet vs XGBoost vs ARIMA)

Accuracy comparison table (RMSE, MAPE, SMAPE)

Feature contribution bar chart (from XGBoost SHAP values)

Forecast horizon slicer selector

DAX Measures (Model Metrics)
```
RMSE = SQRT(AVERAGE((fact_revenue[revenue_actual] - fact_revenue[revenue_forecast])^2))

MAPE = 
AVERAGEX(
    fact_revenue,
    ABS(fact_revenue[revenue_actual] - fact_revenue[revenue_forecast]) 
        / fact_revenue[revenue_actual]
)
```

4️⃣ Scenario Planning – Economic Shock Simulator
Purpose:

Model revenue impact using hypothetical economic shocks.

Visuals

What-If parameters:

% Inflation Increase

Interest Rate Shock

Consumer Spending Index

Scenario Output Table:

Base Case

Low Case

High Case

Worst Case

Tornado chart for sensitivity analysis

Simulation timeline chart

What-If Parameters (Power BI built-in)

Inflation_Shock[%]

Interest_Shock[%]

Demand_Shock[%]

DAX
```
Scenario Forecast Revenue =
[Forecast Revenue] * (1 + 'Inflation_Shock'[Inflation_Shock Value] * 0.3)
```

5️⃣ Monte Carlo Risk Simulation
Purpose:

Illustrates uncertainty bands and probabilistic outcomes.

Visuals

Histogram of simulated outcomes

Box & whisker plot for percentiles

P5 / P50 / P95 cards

Line chart with shaded uncertainty intervals

Data

Monte Carlo outputs are imported as:

simulation_run

simulated_revenue

percentile_key

6️⃣ Product & Region Drilldown
Purpose:

Identify pockets of risk and opportunity.

Visuals

Hierarchical drilldown: Region → Country → Product

Clustered bar: Revenue volatility by category

Waterfall: YOY changes by product

Running totals table

DAX
```
Volatility = STDEVX.P(VALUES(fact_revenue[date]), [Total Revenue])
```

7️⃣ Financial Stress Testing Dashboard
Purpose:

Quantify how extreme events (recession, spikes in inflation) impact revenue.

Visuals

Stress test selector:

Mild recession

Moderate recession

Severe recession

Post-shock recovery

Scenario waterfall chart

Table of revenue impacts by region & product

KPI risk signals:

High-risk regions

High elasticity products

Negative margins

DAX
```
StressTestRevenue =
SWITCH(
    SELECTEDVALUE('StressTest'[Scenario]),
    "Mild Recession", [Forecast Revenue] * 0.97,
    "Moderate Recession", [Forecast Revenue] * 0.92,
    "Severe Recession", [Forecast Revenue] * 0.85,
    [Forecast Revenue]
)
```

## 🧩 3. Filters & Slicers (Used Across Pages)

Date range

Region

Product Category

Economic Indicator

Scenario Selector

Forecast Model Selector

Confidence Interval Toggle
