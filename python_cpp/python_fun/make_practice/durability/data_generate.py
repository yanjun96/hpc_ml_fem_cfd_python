import argparse
import os
import numpy as np
import pandas as pd


def generate_data(n_samples: int = 1000, seed: int = 42) -> pd.DataFrame:
    """Generate synthetic fatigue/durability data.

    Returns a DataFrame with both predicted and "measured" fatigue life.
    """
    rng = np.random.default_rng(seed)

    # Base input features
    data = pd.DataFrame({
        "material_E": rng.uniform(190, 220, n_samples),
        "material_density": rng.uniform(7.5, 8.2, n_samples),
        "surface_finish": rng.uniform(0.1, 3.0, n_samples),
        "load_mean": rng.uniform(100, 800, n_samples),
        "load_amplitude": rng.uniform(50, 500, n_samples),
        "temperature": rng.uniform(40, 160, n_samples),
        "rpm": rng.uniform(500, 6000, n_samples),
        "stress_max": rng.uniform(50, 600, n_samples),
        "stress_ratio": rng.uniform(-1.0, 0.5, n_samples),
        "geometry_factor": rng.uniform(0.8, 1.5, n_samples),
        "simulation_time": rng.uniform(0.1, 5.0, n_samples)
    })

    # Simulated FEM-predicted fatigue life
    data["predicted_fatigue_life"] = (
        1e7 / (data["stress_max"] * data["geometry_factor"]) *
        np.exp(-0.002 * (data["temperature"] - 40)) *
        (1 - 0.2 * data["stress_ratio"]) +
        rng.normal(0, 1e5, n_samples)
    ).clip(1e4, 1e7)

    # Add bias + noise to simulate measurement deviation
    bias_factor = (
        1.0
        + 0.05 * np.sin(data["temperature"] / 50)  # systematic bias due to temperature
        - 0.03 * (data["surface_finish"] - 1.0)    # effect of surface quality
        + rng.normal(0, 0.05, n_samples)            # random test variability
    )

    # "Measured" fatigue life = FEM life * bias
    data["measured_fatigue_life"] = (
        data["predicted_fatigue_life"] * bias_factor
    ).clip(1e4, 1e7)

    # Error column for easy visualization
    data["relative_error_%"] = (
        100 * (data["measured_fatigue_life"] - data["predicted_fatigue_life"]) /
        data["predicted_fatigue_life"]
    )

    return data


def main():
    parser = argparse.ArgumentParser(description="Generate synthetic fatigue/durability data")
    parser.add_argument("--n", "-n", type=int, default=1000, help="number of samples to generate")
    parser.add_argument("--seed", type=int, default=42, help="random seed")
    parser.add_argument("--out", "-o", type=str, default="durability_dataset.csv", help="output CSV file")
    args = parser.parse_args()

    data = generate_data(n_samples=args.n, seed=args.seed)

    outdir = os.path.dirname(args.out) or "."
    if outdir and not os.path.exists(outdir):
        os.makedirs(outdir, exist_ok=True)

    data.to_csv(args.out, index=False)
    print(f"Saved {len(data)} samples to {args.out}")


if __name__ == "__main__":
    main()
