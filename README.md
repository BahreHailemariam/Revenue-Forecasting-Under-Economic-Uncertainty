# 📈 Revenue Forecasting Under Economic Uncertainty

_A Machine Learning + Time Series + Scenario-Modeling Project_

## 📝 Overview

This project predicts future revenue trends for a business operating in unstable economic conditions. The goal is to build a robust forecasting system that:

- Handles **economic shocks** (inflation spikes, recession periods, supply chain disruption)

- Incorporates **external macroeconomic variables** (GDP, CPI, unemployment, consumer sentiment)

- Simulates **multiple what-if scenarios** (best case, base case, worst case)

- Produces **actionable insights** to support strategic planning and finance teams

- Powers **Power BI dashboards** for real-time analysis

The project uses **Python, SQL, Prophet/ARIMA/XGBoost,** and **Power BI.**

## 🎯 Business Problem

Companies face unpredictable changes caused by:

- Inflation volatility

- Interest rate changes

- Market disruptions

- Consumer confidence shifts

Traditional forecasting models fail because they assume stable patterns.
This solution introduces **uncertainty-aware forecasting*** with:

- Time series modeling

- External regressors

- Stress-testing scenarios

- Monte-Carlo simulations

## 🚀 Key Features
**✔ Combined ML + Time Series Modeling**

- Prophet with regressors

- XGBoost regressors

- ARIMA/SARIMA baseline

- Feature drift checks

**✔ Scenario Modeling**

Simulates how revenue changes under:

- 🔵 **Optimistic scenario:** High demand + stable inflation

- ⚪ **Baseline scenario:** Expected economic trend

- 🔴 **Pessimistic scenario:** Low demand + recession shock

**✔ Economic Indicators Included**

- CPI (inflation)

- Unemployment rate

- GDP growth

- Consumer sentiment index

- Industry-specific leading indicators

**✔ Automated Data Pipeline**

- Cleans raw sales data

- Joins external economic datasets

- Generates features

- Produces monthly or weekly forecasts

**✔ Power BI Integration**

- Dynamic dashboard pages:

- Revenue trends

- Forecast vs actuals

- Scenario planner

- Leading economic indicator correlations

## 📂 Project Structure

```bash
Revenue_Forecasting_Uncertainty/
│
├── data/
│   ├── raw/                 # Source CSVs (sales, economic indicators)
│   └── processed/           # Cleaned and merged datasets
│
├── scripts/
│   ├── load_data.py         # Load and validate datasets
│   ├── clean_data.py        # Impute, normalize, join data
│   ├── feature_engineering.py # Lag features, rolling windows, macro features
│   ├── forecast_models.py   # Prophet/XGBoost/ARIMA models
│   ├── scenario_simulation.py # Stress testing & Monte Carlo
│   ├── evaluate_model.py    # RMSE/MAPE/backtesting
│   └── app.py               # Streamlit forecast visualizer (optional)
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_cleaning.sql
│   ├── 03_feature_engineering.sql
│   ├── 04_kpi_metrics.sql
│   └── 05_views_for_powerbi.sql
│
├── dashboard/
│   └── PowerBI_Report_Spec.md
│
├── docs/
│   └── Workflow_Spec.md
│
├── models/
│   └── revenue_forecast_model.pkl
│
├── requirements.txt
└── README.md
```
