# load_data.py

import pandas as pd
from pathlib import Path

DATA_DIR = Path("../data")

def load_sales():
    """Load historical revenue data."""
    path = DATA_DIR / "raw" / "sales.csv"
    df = pd.read_csv(path, parse_dates=["date"])
    return df

def load_macro():
    """Load macroeconomic indicators (CPI, unemployment, GDP, sentiment)."""
    path = DATA_DIR / "raw" / "macro.csv"
    df = pd.read_csv(path, parse_dates=["date"])
    return df

def load_all_data():
    return {
        "sales": load_sales(),
        "macro": load_macro()
    }

if __name__ == "__main__":
    data = load_all_data()
    print("Loaded datasets:")
    for k, df in data.items():
        print(f"- {k}: {df.shape}")
