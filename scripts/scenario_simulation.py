# scenario_simulation.py

import numpy as np
import pandas as pd
import joblib
from feature_engineering import assemble_features

def apply_scenario(df, inflation_factor=1.0, sentiment_shift=0.0, unemployment_shift=0.0):
    df = df.copy()
    df["cpi"] *= inflation_factor
    df["consumer_sentiment"] += sentiment_shift
    df["unemployment_rate"] += unemployment_shift
    return df

def monte_carlo_simulation(model, df, n=1000):
    features = df.drop(columns=["date", "revenue"])
    base_preds = model.predict(features)

    simulations = []
    for _ in range(n):
        noise = np.random.normal(0, base_preds.std() * 0.1, len(base_preds))
        simulations.append(base_preds + noise)

    return np.array(simulations)

def run_scenarios():
    df = assemble_features()
    model = joblib.load("../models/xgboost_model.pkl")

    scenarios = {
        "optimistic": apply_scenario(df, inflation_factor=0.98, sentiment_shift=5),
        "baseline": df,
        "pessimistic": apply_scenario(df, inflation_factor=1.03, unemployment_shift=1),
    }

    results = {}
    for name, sdf in scenarios.items():
        features = sdf.drop(columns=["date", "revenue"])
        results[name] = model.predict(features)

    return results

if __name__ == "__main__":
    scenarios = run_scenarios()
    print("Scenario keys: - scenario_simulation.py:45", scenarios.keys())
