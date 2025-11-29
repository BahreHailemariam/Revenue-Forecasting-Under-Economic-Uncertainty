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
## 🔧 Tech Stack
Languages & Tools

- Python (pandas, numpy, scikit-learn)

- Prophet

- XGBoost

- statsmodels (ARIMA/SARIMA)

- SQL (Postgres / SQL Server)

- Power BI / Power Query

- Streamlit

- Jupyter Notebook

## 🛠 Detailed Workflow
**1. Data Ingestion**

- Load sales history

- Load macroeconomic datasets via API

   - FRED API (Inflation, GDP, unemployment)

   - Consumer sentiment index

**2. Cleaning & Normalization**

- Impute missing months

- Handle outliers using IQR or STL decomposition

- Normalize economic data to matching frequency

**3. Feature Engineering**

- Lag features (lag1, lag3, lag6, lag12)

- Rolling means (3M, 6M)

- Year-over-Year % change

- Inflation-adjusted revenue

- Leading indicators (economic → revenue shift)

**4. Forecast Model Pipeline**

Models trained:
| Model                | Purpose                                  |
| -------------------- | ---------------------------------------- |
| Prophet + regressors | Trend + seasonality + external variables |
| XGBoost              | Captures non-linear behavior             |
| ARIMA/SARIMA         | Baseline classical model                 |

Backtesting window:

```24–36 months rolling forecast validation```

**5. Scenario Simulation**

Each scenario modifies:

- CPI projections

- Consumer sentiment

- Demand elasticity

- Macro shock multipliers

Example pessimistic shock:
```matlab
unemployment +2%
consumer_spending -3%
inflation +1.5%
```

**6. Power BI Reporting**

- Forecast vs Actual charts

- Scenario comparison

- Economic impacts

- Seasonality & trend decomposition

- Demand elasticity visuals

## 📊 Power BI Dashboard Pages
**1️⃣ Revenue Overview**

- Revenue YoY & MoM

- Trend + seasonality decomposition

- Industry comparison

**2️⃣ Forecast & Scenario Planner**

- Baseline forecast

- Optimistic & pessimistic overlays

- Parameter sliders for inflation, consumer sentiment

**3️⃣ Economic Indicator Impact**

- Correlation matrix

- Revenue vs CPI

- Revenue vs unemployment

- Elasticity curve

**4️⃣ Risk & Sensitivity Analysis**

- Tornado chart

- Contribution to variance

- Shock modeling

🧪 Model Evaluation

Metrics included:

- RMSE

- MAE

- MAPE

- sMAPE

- Backtesting accuracy

- Confidence intervals

Example acceptable thresholds:
```matlab
MAPE < 12%
RMSE reduction vs baseline > 20%
```
## 🗂 Example Use Cases

- Financial planning (FP&A)

- Budgeting and forecasting

- Investment decision-making

- Stress testing & risk management

- Price strategy

- Scenario analysis during recessions

 ## 🚀 How to Run the Project
**1. Install dependencies**
```bash
pip install -r requirements.txt
```
**3. Run ETL pipeline**
```bash
python scripts/load_data.py
python scripts/clean_data.py
python scripts/feature_engineering.py
```
**4. Train Forecast Models**
 ```bash
python scripts/forecast_models.py
```
**5. Generate scenarios**
```bash
python scripts/scenario_simulation.py
```
**5. Launch Streamlit app (optional)**
```arduino
streamlit run app.py
```
## 📦 Deliverables

- Machine learning forecasting model

- Scenario simulation engine

- Power BI dashboard

- SQL analytics layer

- Clean, reusable ETL pipeline
