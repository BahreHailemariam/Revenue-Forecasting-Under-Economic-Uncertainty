# feature_engineering.py

import pandas as pd
import numpy as np
from clean_data import clean_all

def add_lag_features(df, col="revenue", lags=[1, 3, 6, 12]):
    for lag in lags:
        df[f"{col}_lag{lag}"] = df[col].shift(lag)
    return df

def add_rolling_features(df, col="revenue"):
    df["revenue_roll3"] = df[col].rolling(3).mean()
    df["revenue_roll6"] = df[col].rolling(6).mean()
    return df

def add_yoy_change(df, col="revenue"):
    df[f"{col}_yoy"] = df[col].pct_change(12)
    return df

def adjust_for_inflation(df):
    df["revenue_real"] = df["revenue"] / (df["cpi"] / df["cpi"].iloc[0])
    return df

def assemble_features():
    df = clean_all()

    df = add_lag_features(df)
    df = add_rolling_features(df)
    df = add_yoy_change(df)
    df = adjust_for_inflation(df)

    df = df.dropna()

    return df

if __name__ == "__main__":
    df = assemble_features()
    print(df.tail())
