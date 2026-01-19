import argparse
import json
import os
from typing import Tuple

try:
    import joblib
    def _save(obj, path):
        joblib.dump(obj, path)
    def _load(path):
        return joblib.load(path)
except Exception:
    import pickle
    def _save(obj, path):
        with open(path, "wb") as f:
            pickle.dump(obj, f)
    def _load(path):
        with open(path, "rb") as f:
            return pickle.load(f)
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error, r2_score
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler


def load_data(path: str) -> pd.DataFrame:
    return pd.read_csv(path)


def prepare_xy(df: pd.DataFrame) -> Tuple[pd.DataFrame, pd.Series]:
    # target: measured_fatigue_life
    if "measured_fatigue_life" not in df.columns:
        raise ValueError("CSV must contain 'measured_fatigue_life' column")
    X = df.drop(columns=["measured_fatigue_life"])
    y = df["measured_fatigue_life"].values
    return X, y


def train_and_evaluate(X, y, out_dir: str, random_state: int = 42):
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=random_state
    )

    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)

    model = RandomForestRegressor(n_estimators=100, random_state=random_state, n_jobs=-1)
    model.fit(X_train_scaled, y_train)

    y_pred = model.predict(X_test_scaled)

    rmse = float(np.sqrt(mean_squared_error(y_test, y_pred)))
    r2 = float(r2_score(y_test, y_pred))

    os.makedirs(out_dir, exist_ok=True)
    _save(model, os.path.join(out_dir, "rf_model.joblib"))
    _save(scaler, os.path.join(out_dir, "scaler.joblib"))

    # Save predictions for plotting
    pred_df = pd.DataFrame({"y_test": y_test, "y_pred": y_pred})
    pred_df.to_csv(os.path.join(out_dir, "predictions.csv"), index=False)

    # Feature importances
    try:
        importances = model.feature_importances_
        fi = pd.Series(importances, index=X.columns).sort_values(ascending=False)
        fi.to_csv(os.path.join(out_dir, "feature_importances.csv"))

        fig, ax = plt.subplots(figsize=(8, 5))
        fi.plot.bar(ax=ax)
        ax.set_ylabel("importance")
        ax.set_title("Feature importances")
        fig.tight_layout()
        fig.savefig(os.path.join(out_dir, "feature_importances.png"), dpi=150)
        plt.close(fig)
    except Exception:
        pass

    # Actual vs predicted scatter
    fig, ax = plt.subplots(figsize=(6, 6))
    ax.scatter(y_test, y_pred, s=8, alpha=0.6)
    mx = max(y_test.max(), y_pred.max())
    mn = min(y_test.min(), y_pred.min())
    ax.plot([mn, mx], [mn, mx], color="k", linewidth=0.8)
    ax.set_xlabel("Actual measured fatigue life")
    ax.set_ylabel("Predicted by model")
    ax.set_title("Actual vs Predicted")
    fig.tight_layout()
    fig.savefig(os.path.join(out_dir, "actual_vs_predicted.png"), dpi=150)
    plt.close(fig)

    metrics = {"rmse": rmse, "r2": r2, "n_test": int(len(y_test))}
    with open(os.path.join(out_dir, "metrics.json"), "w") as f:
        json.dump(metrics, f, indent=2)

    print(f"Saved model, scaler, predictions and metrics to {out_dir}")
    return metrics


def main():
    parser = argparse.ArgumentParser(description="Train an ML model on durability data")
    parser.add_argument("--csv", required=True, help="input CSV file (from data_generate.py)")
    parser.add_argument("--outdir", default="durability_results", help="output folder for model and plots")
    parser.add_argument("--seed", type=int, default=42, help="random seed")
    args = parser.parse_args()

    df = load_data(args.csv)
    X, y = prepare_xy(df)
    # ensure columns are numeric; drop non-numeric if any
    X = X.select_dtypes(include=["number"]).copy()

    metrics = train_and_evaluate(X, y, out_dir=args.outdir, random_state=args.seed)
    print(json.dumps(metrics, indent=2))


if __name__ == "__main__":
    main()
