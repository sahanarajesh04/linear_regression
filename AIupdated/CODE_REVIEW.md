# Code Review: `assignment3` Branch

**Reviewer perspective:** Class GitHub pull request review  
**Branch reviewed:** `assignment3` (latest commit: `6a5eeb6`)  
**Scope:** Part 1 manual work, Part 2 CLI scripts, `AI/` folder, notebooks, plots, README, repo layout

---

## Summary

The `assignment3` branch shows clear progress on Assignment 3 Part A. The **Part 1 notebooks and updated analysis** successfully read `regression_data.csv`, produce scatter plots, fit linear models, overlay regression lines, compute several diagnostics, and save PNG output. The latest commit adds useful plot annotations (equation, correlation, MSE) and interpretation comments.

However, the branch is **not fully submission-ready** as a cohesive assignment package. The biggest gaps are:

1. **Part 2 CLI scripts are broken** because notebook code was pasted below the CLI logic.
2. **Part 1 “updated” `.py`/`.r` files are not CLI scripts** — they are notebook exports with hard-coded column names.
3. The **root `README.md` is still a placeholder** and does not explain how to run anything.
4. **Repo organization is confusing** (`Part 1/`, `Part 2/`, `AI/`, duplicate CSVs, inconsistent output filenames).

The `AI/` folder is the closest match to a complete, runnable CLI + notebook workflow, but it reports **RMSE instead of MSE** and omits **correlation** on the plot/stdout, which your Part 1 enhancements already include.

**Overall:** Strong manual analysis in Part 1, but fix Part 2 CLI bugs and documentation before merging/submitting.

---

## Strengths

### Part 1 notebooks and enhanced analysis

- **Assignment core workflow is present:** read CSV → scatter plot → fit model → overlay line → save plot.
- The **final Python notebook cell** uses `scipy.stats.linregress` and `sklearn.metrics.mean_squared_error` to compute slope, intercept, correlation (`r`), and MSE, then annotates the plot and saves `linear_regression_python_output.png`.
- The **final R notebook cell** computes slope, intercept, correlation, and MSE, saves `linear_regression_r_output.png`, and includes a thoughtful written interpretation.
- **Output plots are committed**, which helps graders verify results without re-running code.
- **HTML exports** (`python lin reg updated.html`, `r lin reg updated.html`) provide a readable static submission artifact.

### AI-assisted folder (`AI/`)

- Clean, **underscore-based filenames** (`python_lin_reg.py`, `r_lin_reg.r`) that work well on the command line.
- **Proper CLI argument parsing** (`<filename> <x_column> <y_column>`) with column validation in both Python and R.
- **`run_lin_reg.sh`** automates running both languages and exporting HTML — good beginner-friendly tooling.
- **`AI/README.md`** is clear, well-structured, and explains setup files in plain language.

### General

- Commit message on `assignment3` (`Assignment 3: Regression annotations, diagnostics, and plots`) accurately describes the Part 1 changes.
- `.gitignore` excludes `.ipynb_checkpoints/`.

---

## Issues to Fix

### 1. Part 2 R script fails after the CLI section (bug)

`Part 2/r_lin_reg.r` runs the CLI block first (which can succeed), but then continues into **hard-coded notebook code** that calls `read.csv("regression_data.csv")`. When run from `Part 2/`, that file does not exist, so the script errors out:

```text
Error in file(file, "rt") : cannot open the connection
cannot open file 'regression_data.csv': No such file or directory
```

**Fix:** Split Part 2 into standalone CLI-only scripts. Remove trailing notebook code from `Part 2/python_lin_reg.py` and `Part 2/r_lin_reg.r`.

### 2. Part 2 Python script blocks on `plt.show()` (bug)

Running `python Part 2/python_lin_reg.py ../regression_data.csv YearsExperience Salary` hangs because the script calls `plt.show()` at the end. For CLI/batch use, scripts should save the plot and exit (use `plt.close()` instead of `plt.show()`).

### 3. Part 2 Python `model.fit()` call is incorrect (bug)

In `Part 2/python_lin_reg.py`:

```python
model.fit(data[[x_col]], data[[y_col]])
```

The second argument should be a 1D target vector (`data[y_col]`), not a one-column DataFrame. This may still “work” in some sklearn versions but is non-idiomatic and can cause subtle shape warnings.

### 4. Part 1 “updated” scripts are not CLI scripts

`Part 1/python lin reg updated.py` and `Part 1/r lin reg updated.r` are **nbconvert-style exports** of notebook cells. They:

- Do **not** accept `<filename> <x_column> <y_column>` CLI arguments
- Hard-code `YearsExperience` and `Salary`
- Include duplicate/exploratory cells (e.g., repeated `read.csv`, `os.listdir()` in Python)
- Call `plt.show()`, which blocks non-interactive runs

If Part 2 is meant to satisfy the CLI requirement, Part 1 should remain notebook-only; if graders expect CLI scripts in Part 1 as well, these files need refactoring.

### 5. Root README does not match the repo

`README.md` still says:

> New repository that is a clone of Assignment 2 Linear Regression. No edits have been made yet.

This will confuse anyone grading or cloning the repo. It should describe folder layout, how to run Part 1 notebooks, Part 2 CLI scripts, and the `AI/` workflow.

### 6. Inconsistent diagnostics across folders

| Location | Slope / intercept | Correlation | MSE | R² | Plot annotation |
|----------|-------------------|-------------|-----|-----|-----------------|
| Part 1 (final cells) | Yes | Yes | Yes | Partial (Python notebook cell uses `model.score`; not on plot) | Yes |
| Part 2 CLI | No printed stats | No | No | No | Basic plot only |
| `AI/` CLI | Yes (as coefficient/intercept) | No | No (uses RMSE) | Yes | No equation/stats on plot |

For assignment consistency, align diagnostics across Python and R and across Part 1 / Part 2 / `AI/`.

### 7. Plot styling inconsistency in Part 1 R final plot

The enhanced R plot uses `geom_smooth(method = "lm", color = "red")` while points have default styling. Earlier cells use **red points + blue regression line**, which better matches the assignment wording (“overlay the regression line”). The final plot also overlays a red smooth line rather than an explicit `predict()` line in blue.

### 8. Filenames with spaces

Files like `Part 1/python lin reg.ipynb` require careful quoting in shell commands (`python "python lin reg updated.py"`). This is workable but error-prone for beginners. Consider renaming to `python_lin_reg.ipynb` in future cleanup (not required if assignment template used spaces).

### 9. Repo organization and duplicate assets

Tracked layout includes overlapping content:

- `regression_data.csv` at root **and** in `Part 1/` and `AI/`
- Three parallel implementations: `Part 1/`, `Part 2/`, `AI/`
- Stray generated file: `Part 2/Rplots.pdf`
- Inconsistent output names: `lin_reg_py_output.png` (`AI/`) vs `linear_regression_python_output.png` (`Part 1/`, `Part 2/`)

Graders may not know which folder is the “official” submission.

### 10. Dataset size

Both root and `Part 1/regression_data.csv` contain **10 data rows** (11 lines including header). If the full class dataset is larger, confirm you are not accidentally submitting a truncated sample.

---

## Suggested Improvements

### High priority (before merge/submission)

1. **Repair Part 2 CLI scripts**
   - Keep only CLI logic; delete appended notebook code.
   - Replace `plt.show()` with `plt.savefig(...); plt.close()`.
   - Print slope, intercept, correlation, MSE, and R-squared.
   - Add plot annotations matching Part 1.

2. **Update root `README.md`**
   - Map folders to assignment parts (manual vs CLI vs AI-assisted).
   - Include exact run commands for Python, R, and bash.
   - List expected output filenames.

3. **Choose one canonical output naming scheme**
   - Example: always write `linear_regression_python_output.png` and `linear_regression_r_output.png`.

### Medium priority ( clarity / polish )

4. **Clean up Part 1 notebooks**
   - Remove or markdown-wrap obsolete early cells (duplicate reads, `os.listdir()` exploration) so the “final story” is easy to follow.
   - Add **R-squared** to the Python final plot annotation for parity with R’s `summary(model)`.

5. **Align `AI/` scripts with Part 1 diagnostics**
   - Report **MSE** (assignment wording) rather than only RMSE.
   - Add **correlation** and on-plot equation/stats block.

6. **Remove or gitignore incidental artifacts**
   - `Part 2/Rplots.pdf`
   - Consider gitignoring regenerated PNGs if graders run scripts themselves (optional — committing outputs is fine if required).

### Lower priority (nice to have)

7. **Add a short “How to grade this” section** to README with one command per language.

8. **Symlink or document a single source of truth** for `regression_data.csv` instead of maintaining three copies.

9. **Untracked `AIupdated/` folder:** If this is part of the assignment deliverable, add and document it; otherwise add to `.gitignore` or merge useful pieces into `AI/`.

---

## Substantive comment to address

> **Refactor `Part 2/r_lin_reg.r` and `Part 2/python_lin_reg.py` into standalone CLI scripts.**

Right now, both Part 2 files look like a CLI header with an entire notebook pasted underneath. That is the main reason the R script fails in practice and the Python script hangs.

A minimal acceptable Part 2 R script should:

1. Parse 3 CLI args
2. Validate columns exist
3. Fit `lm(y ~ x, data = df)`
4. Compute correlation, MSE, and R-squared
5. Build one ggplot with points + `predict()` line
6. `ggsave()` and print diagnostics
7. **Stop there** — no second `read.csv("regression_data.csv")` block

Example target behavior:

```bash
cd "Part 2"
Rscript r_lin_reg.r ../regression_data.csv YearsExperience Salary
python python_lin_reg.py ../regression_data.csv YearsExperience Salary
```

Both commands should exit cleanly and produce annotated PNGs without requiring Jupyter or a GUI.

---

## Test plan (for the author)

- [ ] Run Part 1 notebooks top-to-bottom; confirm final cells save PNGs and print expected stats (~slope 8285, r ~ 0.89, R² ~ 0.79).
- [ ] Run Part 2 Python and R CLI scripts from their folder with explicit CSV path; confirm **no hang**, **no trailing errors**, PNG saved.
- [ ] Run `bash AI/run_lin_reg.sh regression_data.csv YearsExperience Salary` from `AI/`.
- [ ] Open root `README.md` and verify instructions match actual filenames.
- [ ] Confirm which folder(s) the assignment submission expects and remove/label duplicates accordingly.

---

## Verdict

**Request changes before merge.** Part 1 demonstrates solid regression analysis and improved visualization, but Part 2 CLI scripts need bug fixes, the root README needs real content, and repo organization should be clarified so graders know what to run.
