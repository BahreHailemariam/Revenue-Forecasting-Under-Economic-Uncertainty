# 🧠 Workflow Specification  — Revenue Forecasting Under Economic Uncertainty

_A complete end-to-end pipeline specifications, and alerts_

## 📌 1. Overview

This workflow describes a full data-to-decision pipeline for forecasting revenue under volatile macroeconomic conditions.
It integrates:

- **Historical business revenue**

- **Macroeconomic indicators (CPI, unemployment, GDP growth, consumer sentiment)**

- **Machine Learning forecasting models**

- **Scenario stress testing**

- **Uncertainty-aware insights for Power BI and Streamlit**

Designed for use by FP&A teams, executives, and data science groups.

## 🚀 2. End-to-End Architecture
```powershell
Data Sources → Data Ingestion → Data Cleaning → Feature Engineering → 
Model Training → Backtesting → Scenario Simulation → KPI Calculation → 
Forecast Output → Power BI & Streamlit Dashboards
```

## 📥 3. Data Ingestion Layer
**3.1 Internal Data Sources**

- Monthly / weekly **revenue**

- Units sold

- Channel breakdown (online, in-store, partners)

**3.2 External Economic Data**

Pulled from:

- **Federal Reserve FRED API**

- **World Bank Indicators**

- **OECD**

- **Consumer Sentiment Index (UMich)**

**3.3 Ingestion Pipeline Tasks**

- Scheduled ingestions (daily or monthly)

- Schema validation

- Duplicate detection

- Write raw files to:
     `data/raw/sales/`
     `data/raw/macro/`

**3.4 Outputs**

- `sales_raw.csv`

- `macro_raw.csv`
## 🧹 4. Data Cleaning & Harmonization
**4.1 Revenue Data Cleaning**

- Remove negative revenue

- Fix missing dates with forward-fill

- Resolve inconsistent channel naming

- Remove outliers with IQR or MAD

**4.2 Economic Data Cleaning**

- Fill missing months using linear interpolation

- Normalize units (CPI = index base 100)

- Remove noise with rolling smoothing if required

**4.3 Time Alignment**

Ensure single continuous time series:

```pgsql
full_date_range = MIN(sales.date) → MAX(sales.date)
```

**4.4 Output**

Cleaned tables written to:

- `data/processed/sales_clean.csv`

- `data/processed/macro_clean.csv`

## 🛠️ 5. Feature Engineering Layer

Feature store builds predictive signals essential for forecasting.

**5.1 Lag & Rolling Window Features**

- revenue_lag_1

- revenue_lag_3

- revenue_lag_6

- revenue_lag_12

- rolling_avg_3

- rolling_avg_6

- rolling_std_6

**5.2 Trend & Seasonality Extraction**

- Month index

- Year index

- Seasonality sin/cos transforms

**5.3 Macroeconomic Features**

Merged from macro tables:

- Inflation-adjusted revenue (`real_revenue`)

- GDP growth impact

- Consumer sentiment leading signal

- CPI volatility index

**5.4 Revenue Sensitivity Features**

Elasticity-like indicators:
```powershell
ΔRevenue / ΔCPI
ΔRevenue / ΔUnemploymentRate
```
**5.5 Output**

`data/features/feature_store.csv`

## 🤖 6. Forecasting Models

Multiple models are trained to handle stability vs volatility.

**6.1 Model Types**

1.Prophet
   Excellent for business seasonality

2.ARIMA / SARIMAX
   Best for linear patterns with macroeconomic regressors

3.XGBoost Regressor
   Handles non-linear interactions, elasticities, and external shocks

4.(Optional) Deep Learning (LSTM)

**6.2 Workflow**

- Train using 3–5 years of data

- Hyperparameter search

- Cross-validation with rolling windows

- Weighted model ensemble (if enabled)

**6.3 Output**

Trained model files:
`models/prophet_model.pkl`
`models/xgb_model.pkl`

Predictions written to:
`data/predictions/base_forecast.csv`
