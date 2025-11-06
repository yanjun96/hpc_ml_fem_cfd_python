import argparse
import json
import os
import shutil
import subprocess
from pathlib import Path

import matplotlib.pyplot as plt
import pandas as pd


LATEX_TEMPLATE = r"""
\documentclass{article}
\usepackage{graphicx}
\usepackage{booktabs}
\begin{document}
\title{Durability / Fatigue Model Report}
\author{Auto-generated}
\date{\today}
\maketitle
\section{Summary}
\begin{itemize}
  \item RMSE: %s
  \item R\textsuperscript{2}: %s
  \item Test samples: %s
\end{itemize}
\section{Actual vs Predicted}
\begin{figure}[h]
\centering
\includegraphics[width=0.7\textwidth]{%s}
\caption{Actual vs Predicted fatigue life}
\end{figure}
\section{Feature importances}
\begin{figure}[h]
\centering
\includegraphics[width=0.7\textwidth]{%s}
\caption{Feature importances (if available)}
\end{figure}
\end{document}
"""


def compile_tex(tex_path: str, workdir: str) -> bool:
    pdflatex = shutil.which("pdflatex")
    if not pdflatex:
        return False
    # run twice for TOC/refs. When using cwd, pass only the basename to pdflatex
    tex_name = os.path.basename(tex_path)
    proc1 = subprocess.run([pdflatex, "-interaction=nonstopmode", tex_name], cwd=workdir)
    proc2 = subprocess.run([pdflatex, "-interaction=nonstopmode", tex_name], cwd=workdir)
    return proc1.returncode == 0 and proc2.returncode == 0


def create_pdf_fallback(out_pdf: str, img_paths: list, metrics: dict):
    # Simple one-page PDF combining images and metrics using matplotlib
    from matplotlib.backends.backend_pdf import PdfPages

    with PdfPages(out_pdf) as pdf:
        fig, axes = plt.subplots(2, 1, figsize=(8.27, 11.7))
        axes[0].axis('off')
        txt = f"RMSE: {metrics.get('rmse'):.3g}\nR2: {metrics.get('r2'):.3g}\nN_test: {metrics.get('n_test', '')}"
        axes[0].text(0.01, 0.5, txt, fontsize=12)

        # embed first image (actual vs predicted)
        img = plt.imread(img_paths[0])
        axes[1].imshow(img)
        axes[1].axis('off')
        pdf.savefig(fig)
        plt.close(fig)


def main():
    parser = argparse.ArgumentParser(description="Create PDF report from training outputs")
    parser.add_argument("--results", default="durability_results", help="results directory with metrics and plots")
    parser.add_argument("--out", default="durability_report.pdf", help="output PDF path")
    args = parser.parse_args()

    results = Path(args.results)
    metrics_file = results / "metrics.json"
    avp = results / "actual_vs_predicted.png"
    fi = results / "feature_importances.png"

    if not metrics_file.exists():
        raise FileNotFoundError(f"metrics.json not found in {results}")

    with open(metrics_file) as f:
        metrics = json.load(f)

    # Try LaTeX route
    tex = LATEX_TEMPLATE % (
        f"{metrics.get('rmse'):.3g}", f"{metrics.get('r2'):.3g}", metrics.get('n_test', ''),
        avp.name if avp.exists() else "",
        fi.name if fi.exists() else ""
    )

    workdir = str(results)
    tex_path = os.path.join(workdir, "report.tex")
    with open(tex_path, "w") as f:
        f.write(tex)

    # If images are in results, leave them. LaTeX compile needs pdflatex installed.
    ok = compile_tex(tex_path, workdir)
    out_pdf_path = os.path.join(workdir, "report.pdf")
    if ok and os.path.exists(out_pdf_path):
        # move to desired location
        shutil.copy(out_pdf_path, args.out)
        print(f"Wrote PDF report to {args.out} (via pdflatex)")
        return

    # fallback: combine via matplotlib
    img_paths = []
    if avp.exists():
        img_paths.append(str(avp))
    elif fi.exists():
        img_paths.append(str(fi))

    create_pdf_fallback(args.out, img_paths or [str(avp) if avp.exists() else str(fi)], metrics)
    print(f"Wrote PDF report to {args.out} (fallback)")


if __name__ == "__main__":
    main()
