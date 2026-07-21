# Assignment 3, Part A — AI-Enhanced Linear Regression

This folder contains an **AI-assisted version** of Part A. Your manual work in `Part 1/` is untouched.

All files here read the shared dataset `regression_data.csv` (linked from the project root), perform linear regression in **Python** and **R**, and save output plots.

---

## Files in this folder

| File | Purpose |
|------|---------|
| `regression_data.csv` | Symlink to the project dataset |
| `python_lin_reg.py` | Python CLI script |
| `r_lin_reg.r` | R CLI script |
| `python_lin_reg.ipynb` | Step-by-step Python notebook |
| `r_lin_reg.ipynb` | Step-by-step R notebook |
| `run_lin_reg.sh` | Bash script to run Python, R, and HTML export |

---

## What the analysis does

1. **Read the CSV** — load the table into memory
2. **Scatter plot** — draw dots for each row
3. **Fit a line** — find the best straight line through the dots
4. **Overlay the line** — draw the regression line on top of the scatter plot
5. **Diagnostics** — print slope, intercept, correlation (r), MSE, and R-squared
6. **Save plot** — write a PNG file with the equation and statistics annotated

---

## How to run (CLI)

All scripts accept three arguments:

```text
<filename> <x_column> <y_column>
```

### Python

```bash
cd AIupdated
python python_lin_reg.py regression_data.csv YearsExperience Salary
```

### R

```bash
cd AIupdated
Rscript r_lin_reg.r regression_data.csv YearsExperience Salary
```

### Both at once (Bash)

```bash
cd AIupdated
bash run_lin_reg.sh regression_data.csv YearsExperience Salary
```

---

## Notebooks

Open the notebooks in Jupyter for an interactive, step-by-step walkthrough:

```bash
jupyter lab python_lin_reg.ipynb
jupyter lab r_lin_reg.ipynb
```

At the top of each notebook, change `FILENAME`, `X_COLUMN`, and `Y_COLUMN` if you want to analyze different columns.

---

## Output files

| Output | Created by |
|--------|------------|
| `linear_regression_python_output.png` | Python script or notebook |
| `linear_regression_r_output.png` | R script or notebook |
| `python_lin_reg.html` | `run_lin_reg.sh` (if Jupyter is installed) |
| `r_lin_reg.html` | `run_lin_reg.sh` (if Jupyter is installed) |

---

## Requirements

- **Python:** pandas, matplotlib, scikit-learn
- **R:** ggplot2 (`install.packages("ggplot2")`)

If you already set up the environment from the `AI/` folder (`lin_reg_env`), you can reuse it here.
