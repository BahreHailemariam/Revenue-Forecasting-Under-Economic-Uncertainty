# forecast_models.py

import joblib
import pandas as pd
from feature_engineering import assemble_features

from prophet import Prophet
from sklearn.metrics import mean_absolute_error, mean_squared_error
from sklearn.model_selection import train_test_split
from xgboost import XGBRegressor
import statsmodels.api as sm
import numpy as np

MODEL_DIR = "../models/"

def train_prophet(df):
    p_df = df[["date", "revenue", "cpi", "unemployment_rate", "consumer_sentiment"]].rename(
        columns={"date": "ds", "revenue": "y"}
    )
    model = Prophet()
    model.add_regressor("cpi")
    model.add_regressor("unemployment_rate")
    model.add_regressor("consumer_sentiment")
    model.fit(p_df)
    return model

def train_xgboost(df):
    features = df.drop(columns=["revenue", "date"])
    target = df["revenue"]

    X_train, X_test, y_train, y_test = train_test_split(
        features, target, test_size=0.2, shuffle=False
    )

    model = XGBRegressor(
        n_estimators=300,
        learning_rate=0.05,
        max_depth=5,
        objective="reg:squarederror"
    )
    model.fit(X_train, y_train)

    preds = model.predict(X_test)
    rmse = np.sqrt(mean_squared_error(y_test, preds))
    print("XGBoost RMSE:", rmse)

    return model

def train_arima(df):
    y = df["revenue"]
    model = sm.tsa.statespace.SARIMAX(
        y,
        order=(2,1,2),
        seasonal_order=(1,1,1,12),
        enforce_stationarity=False,
        enforce_invertibility=False,
    )
    arima_model = model.fit()
    return arima_model

def train_all_models():
    df = assemble_features()

    prophet_model = train_prophet(df)
    xg_model = train_xgboost(df)
    arima_model = train_arima(df)

    joblib.dump(prophet_model, MODEL_DIR + "prophet_model.pkl")
    joblib.dump(xg_model, MODEL_DIR + "xgboost_model.pkl")
    arima_model.save(MODEL_DIR + "arima_model.pkl")

    print("Models saved!")

if __name__ == "__main__":
    train_all_models()
