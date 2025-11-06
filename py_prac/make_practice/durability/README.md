Durability automation pipeline
=============================

This folder contains scripts to generate synthetic fatigue/durability data, train a machine learning model, produce diagnostic plots, and create a PDF report (via LaTeX if available or a fallback PDF).

Requirements
------------
- Python 3.8+
- pip packages: numpy, pandas, scikit-learn, matplotlib, joblib

Install (example):

```bash
python -m pip install numpy pandas scikit-learn matplotlib joblib
```

Usage
-----

1. Generate data (CSV):

```bash
python data_generate.py --n 2000 --out durability_dataset.csv
```

2. Train model and generate plots/metrics:

```bash
python train_model.py --csv durability_dataset.csv --outdir durability_results
```

3. Create PDF report (requires pdflatex for a LaTeX-generated PDF):

```bash
python plot_and_report.py --results durability_results --out durability_report.pdf
```

If `pdflatex` is not installed the script will create a simple one-page PDF that embeds the main plot and metrics.

Notes
-----
- The pipeline is intentionally minimal and designed for local experimentation. You can extend the training script to use cross-validation, hyperparameter tuning, persistence of more artifacts, or other models.
