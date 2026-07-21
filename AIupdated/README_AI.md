# Linear Regression Assignment — AI-Generated README

This document describes the **current state of this repository** for Assignment 3 (linear regression). It is an AI-generated guide and does **not** replace the manual `README.md` at the project root.

---

## Goal of the project

This project explores the relationship between **years of work experience** and **salary** using simple **linear regression** in both **Python** and **R**.

You will:

1. Read a CSV dataset
2. Create a scatter plot of two numeric columns
3. Fit a straight-line model (linear regression)
4. Overlay the regression line on the plot
5. Calculate and report model diagnostics
6. Save output plots for submission or review

Linear regression finds the best-fit line:

```text
Salary = slope × YearsExperience + intercept
```

---

## Dataset

**File:** `regression_data.csv` (also copied or linked inside some subfolders)

| Column | Description |
|--------|-------------|
| `YearsExperience` | Years of professional experience (predictor, x-axis) |
| `Salary` | Annual salary in dollars (response, y-axis) |

The dataset contains **10 observations** — enough to demonstrate the workflow, though a larger sample would give more stable estimates.

**Example rows:**

```text
YearsExperience,Salary
1.1,39343.0
3.0,60150.0
4.0,63218.0
```

---

## Repository layout

The repo is organized into manual work, CLI scripts, and AI-assisted versions:

```text
linear_regression/
├── README.md                 # Manual README (placeholder — not overwritten)
├── regression_data.csv       # Main dataset
├── environment.yml           # Conda environment (7030_class_1)
├── setup_env.sh              # Cluster setup script (root)
│
├── Part 1/                   # Manual Assignment 3, Part A
│   ├── python lin reg.ipynb
│   ├── r lin reg.ipynb
│   ├── python lin reg updated.py
│   ├── r lin reg updated.r
│   ├── python lin reg updated.html
│   ├── r lin reg updated.html
│   ├── linear_regression_python_output.png
│   ├── linear_regression_r_output.png
│   └── regression_data.csv
│
├── Part 2/                   # CLI script versions
│   ├── python_lin_reg.py
│   ├── r_lin_reg.r
│   └── linear_regression_*_output.png
│
├── AI/                       # Self-contained AI-assisted project
│   ├── python_lin_reg.py / .ipynb
│   ├── r_lin_reg.r / .ipynb
│   ├── run_lin_reg.sh
│   ├── setup_env.sh
│   ├── environment.yml       # lin_reg_env
│   └── requirements.txt
│
├── AIupdated/                # Enhanced AI-assisted Part A (newer)
│   ├── python_lin_reg.py / .ipynb
│   ├── r_lin_reg.r / .ipynb
│   ├── run_lin_reg.sh
│   └── README.md
│
└── ai/                       # AI-generated documentation (this folder)
    ├── README_AI.md          # This file
    └── PROMPTS.md            # Log of AI prompts used
```

| Folder | Purpose |
|--------|---------|
| `Part 1/` | Manual notebooks and enhanced analysis with plot annotations |
| `Part 2/` | Command-line scripts accepting `<filename> <x_column> <y_column>` |
| `AI/` | Original AI-assisted notebooks, scripts, bash runner, and setup |
| `AIupdated/` | Enhanced AI version with full diagnostics (slope, intercept, r, MSE, R²) |
| `ai/` | AI-generated docs only (does not overwrite manual files) |

---

## Environment setup

You need **Python** (pandas, matplotlib, scikit-learn), **R** (ggplot2), and optionally **Jupyter** for the notebooks.

### Option A — Root / class cluster setup

From the project root:

```bash
bash setup_env.sh
```

This uses `environment.yml` to create/update the **`7030_class_1`** conda environment and registers Python and R Jupyter kernels.

Then activate:

```bash
conda activate 7030_class_1
```

### Option B — AI folder setup (recommended for scripts + notebooks)

```bash
cd AI
bash setup_env.sh
conda activate lin_reg_env
```

This creates **`lin_reg_env`**, installs pip packages from `requirements.txt`, and registers notebook kernels.

### Option C — Minimal manual install

**Python:**

```bash
pip install pandas matplotlib scikit-learn jupyter
```

**R:**

```r
install.packages("ggplot2")
```

---

## Running from the command line

All CLI scripts use the same three arguments:

```text
<filename> <x_column> <y_column>
```

### Recommended: `AIupdated/` (full diagnostics + annotated plots)

```bash
cd AIupdated

python python_lin_reg.py regression_data.csv YearsExperience Salary

Rscript r_lin_reg.r regression_data.csv YearsExperience Salary

bash run_lin_reg.sh regression_data.csv YearsExperience Salary
```

### Alternative: `AI/`

```bash
cd AI
conda activate lin_reg_env

python python_lin_reg.py regression_data.csv YearsExperience Salary
Rscript r_lin_reg.r regression_data.csv YearsExperience Salary
bash run_lin_reg.sh regression_data.csv YearsExperience Salary
```

Outputs: `lin_reg_py_output.png`, `lin_reg_r_output.png` (reports intercept, coefficient, R², RMSE).

### Part 2 scripts

```bash
cd Part 2
python python_lin_reg.py ../regression_data.csv YearsExperience Salary
Rscript r_lin_reg.r ../regression_data.csv YearsExperience Salary
```

> **Note:** Part 2 scripts may need cleanup before submission (e.g., remove trailing notebook code, replace `plt.show()` with `plt.savefig()` + `plt.close()`). See `AIupdated/CODE_REVIEW.md` for details.

---

## Running notebooks (interactive)

**Part 1 (manual):**

```bash
cd "Part 1"
jupyter lab "python lin reg.ipynb"
jupyter lab "r lin reg.ipynb"
```

**AI / AIupdated:**

```bash
cd AIupdated   # or AI
jupyter lab python_lin_reg.ipynb
jupyter lab r_lin_reg.ipynb
```

Select the matching kernel (`7030_class_1`, `lin_reg_env`, or your system Python/R kernel).

---

## Generated outputs

| Output file | Typical location | Created by |
|-------------|------------------|------------|
| `linear_regression_python_output.png` | `Part 1/`, `AIupdated/` | Python script or notebook |
| `linear_regression_r_output.png` | `Part 1/`, `AIupdated/` | R script or notebook |
| `lin_reg_py_output.png` | `AI/` | AI Python CLI |
| `lin_reg_r_output.png` | `AI/` | AI R CLI |
| `python_lin_reg.html` / `r_lin_reg.html` | `AI/`, `AIupdated/` | `run_lin_reg.sh` or manual `nbconvert` |
| `python lin reg updated.html` | `Part 1/` | Exported manual Python notebook |
| `r lin reg updated.html` | `Part 1/` | Exported manual R notebook |

Plots generally show:

- Red scatter points (observations)
- Blue regression line (fitted values)
- Text annotation with equation and statistics (in Part 1 final cells and `AIupdated/`)

---

## Interpreting regression results

On `regression_data.csv`, Python and R produce consistent results (example from `AIupdated/`):

| Statistic | Example value | Meaning |
|-----------|---------------|---------|
| **Slope** | ~8285 | Expected salary increase per additional year of experience (~$8,285/year) |
| **Intercept** | ~29204 | Predicted salary when experience is 0 years (~$29,204; interpret cautiously) |
| **Correlation (r)** | ~0.89 | Strong positive linear association between experience and salary |
| **MSE** | ~17,523,844 | Average squared prediction error; lower is better (scale depends on salary units) |
| **R-squared** | ~0.79 | About 79% of salary variance is explained by years of experience |

### How to read these in plain language

- **Positive slope:** salary tends to rise as experience increases.
- **High r and R²:** the straight-line model fits this dataset reasonably well, but not perfectly — real salaries vary for reasons the model does not capture.
- **Intercept at x = 0:** useful mathematically, but may not be realistic if no employees actually have zero years of experience.
- **MSE:** useful for comparing models on the same data; values look large here because salaries are measured in dollars squared.

### Written interpretation (template)

> On this dataset, salary increases with years of experience. The slope of about **8285** suggests each additional year of experience is associated with roughly **$8,285** higher salary. The correlation (**r ≈ 0.89**) and R-squared (**≈ 0.79**) indicate a strong positive linear trend, though some points deviate from the line (residual error).

---

## Quick reference — which folder should I use?

| Task | Folder |
|------|--------|
| Show manual notebook work | `Part 1/` |
| Run polished CLI with all diagnostics | `AIupdated/` |
| Run bash automation + HTML export | `AI/` or `AIupdated/` |
| AI documentation and prompt log | `ai/` |

---

## Files in `ai/` (this folder)

| File | Description |
|------|-------------|
| `README_AI.md` | This AI-generated project README |
| `PROMPTS.md` | Record of prompts used for AI-assisted work |

Manual documentation at the repo root (`README.md`) is unchanged.
