# evaluate_model.py

import numpy as np
import pandas as pd
import joblib
from sklearn.metrics import mean_absolute_error, mean_squared_error
from feature_engineering import assemble_features

def evaluate_model():
    df = assemble_features()
    model = joblib.load("../models/xgboost_model.pkl")

    features = df.drop(columns=["date", "revenue"])
    target = df["revenue"]

    predictions = model.predict(features)

    rmse = np.sqrt(mean_squared_error(target, predictions))
    mae = mean_absolute_error(target, predictions)
    mape = np.mean(np.abs((target - predictions) / target)) * 100

    print("RMSE:", rmse)
    print("MAE:", mae)
    print("MAPE:", mape)

if __name__ == "__main__":
    evaluate_model()
