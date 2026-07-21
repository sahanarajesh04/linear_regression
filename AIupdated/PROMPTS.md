# AI Prompts Log

Simple record of prompts used for AI-assisted work on this linear regression assignment.

---

## 1. AI-generated enhanced notebooks/scripts

**Prompt:**

> I am working on Assignment 3 for a linear regression project. Please create an AI-assisted version of Part A inside a new AIupdated/ folder without overwriting my manual work. Use my existing dataset regression_data.csv and create enhanced Python and R notebooks/scripts that still meet the assignment requirements: read the CSV, make a scatter plot, fit a linear regression model, overlay the regression line, calculate/print model diagnostics like slope, intercept, correlation, MSE, and R-squared if appropriate, and save output plots. The scripts should accept CLI arguments in the form `<filename> <x_column> <y_column>`. Use clear comments and make the code readable for a beginner. Put all AI-generated files inside AIupdated/.

**Outcome:** Created `AIupdated/` with `python_lin_reg.py`, `r_lin_reg.r`, notebooks, `run_lin_reg.sh`, and `README.md`.

---

## 2. AI code review

**Prompt:**

> Please review my current assignment3 branch as if you are doing a code review for a class GitHub pull request. Focus on whether the notebooks, scripts, output plots, CLI behavior, filenames, README, and repo organization match the assignment instructions. Identify any bugs, missing files, confusing code, or places where the code could be clearer. Write the review in markdown format with sections for "Summary," "Strengths," "Issues to Fix," and "Suggested Improvements." Save the review as ai/CODE_REVIEW.md. Include at least one substantive comment that I could realistically address.

**Outcome:** Generated code review saved as `AIupdated/CODE_REVIEW.md`.

---

## 3. AI-generated README

**Prompt:**

> Generate a fresh README for this linear regression assignment based on the current repo contents and code. Save it as ai/README_AI.md and do not overwrite my manual README. The README should explain the goal of the project, dataset, files included, how to set up the environment, how to run the Python and R scripts from the command line, what outputs are generated, and how to interpret the regression results.
>
> Then create ai/PROMPTS.md listing the prompts I used for: AI-generated enhanced notebooks/scripts, AI code review, and AI-generated README. Keep the prompts log simple and in markdown format.

**Outcome:** Created `ai/README_AI.md` and this file (`ai/PROMPTS.md`).
