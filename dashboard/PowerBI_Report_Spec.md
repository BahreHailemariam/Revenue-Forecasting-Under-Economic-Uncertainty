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

  
