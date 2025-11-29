# app.py

import streamlit as st
import pandas as pd
import joblib
from feature_engineering import assemble_features
from scenario_simulation import run_scenarios

st.title("📈 Revenue Forecasting Under Economic Uncertainty")

df = assemble_features()
model = joblib.load("../models/xgboost_model.pkl")

scenario = st.selectbox(
    "Choose a scenario",
    ["baseline", "optimistic", "pessimistic"]
)

scenarios = run_scenarios()
forecast = scenarios[scenario]

chart_data = pd.DataFrame({
    "date": df["date"],
    "forecast": forecast
})

st.line_chart(chart_data, x="date", y="forecast")

