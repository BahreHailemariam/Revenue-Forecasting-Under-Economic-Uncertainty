# clean_data.py

import pandas as pd
from load_data import load_all_data

def fill_missing_months(df, column):
    """Fill missing months for time series continuity."""
    df = df.set_index("date").asfreq("MS")
    df[column] = df[column].interpolate(method="linear")
    return df.reset_index()

def clean_sales(df):
    df = df.copy()
    df = df.sort_values("date")
    df = fill_missing_months(df, "revenue")

    # Remove negative values
    df["revenue"] = df["revenue"].clip(lower=0)
    return df

def clean_macro(df):
    df = df.copy()
    df = df.sort_values("date")

    macro_cols = ["cpi", "unemployment_rate", "gdp_growth", "consumer_sentiment"]

    for col in macro_cols:
        df = fill_missing_months(df, col)

    return df

def merge_datasets(sales, macro):
    """Join macro regressors to sales dataset."""
    merged = sales.merge(macro, on="date", how="left")
    return merged

def clean_all():
    raw = load_all_data()

    sales = clean_sales(raw["sales"])
    macro = clean_macro(raw["macro"])
    merged = merge_datasets(sales, macro)

    return merged

if __name__ == "__main__":
    df = clean_all()
    print(df.head())
