#!/usr/bin/env python3
"""
Linear Regression Analysis (Assignment 3, Part A) — AI-Enhanced Python Script

This script:
  1. Reads a CSV file
  2. Makes a scatter plot of two columns
  3. Fits a simple linear regression model
  4. Overlays the regression line on the plot
  5. Prints model diagnostics (slope, intercept, correlation, MSE, R-squared)
  6. Saves the plot as a PNG file

Usage:
    python python_lin_reg.py <filename> <x_column> <y_column>

Example:
    python python_lin_reg.py regression_data.csv YearsExperience Salary
"""

import sys

import matplotlib.pyplot as plt
import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score


def print_usage() -> None:
    """Show how to run this script from the command line."""
    print("Usage: python python_lin_reg.py <filename> <x_column> <y_column>")
    print("Example: python python_lin_reg.py regression_data.csv YearsExperience Salary")


def main() -> None:
    # ------------------------------------------------------------------
    # Step 1: Read command-line arguments
    # The user passes three values: CSV path, x column name, y column name
    # ------------------------------------------------------------------
    if len(sys.argv) != 4:
        print_usage()
        sys.exit(1)

    filename = sys.argv[1]
    x_col = sys.argv[2]
    y_col = sys.argv[3]

    # ------------------------------------------------------------------
    # Step 2: Load the CSV into a pandas DataFrame (table)
    # ------------------------------------------------------------------
    try:
        data = pd.read_csv(filename)
    except FileNotFoundError:
        print(f"Error: file not found: {filename}")
        sys.exit(1)

    # Make sure the requested column names actually exist in the file
    if x_col not in data.columns or y_col not in data.columns:
        print(f"Error: columns must be one of {list(data.columns)}")
        sys.exit(1)

    x = data[x_col]
    y = data[y_col]

    # ------------------------------------------------------------------
    # Step 3: Fit a linear regression model
    # The model finds the best straight line: y = slope * x + intercept
    # ------------------------------------------------------------------
    model = LinearRegression()
    # sklearn expects X as a 2D table, so we pass a DataFrame with one column
    model.fit(data[[x_col]], y)

    slope = model.coef_[0]
    intercept = model.intercept_
    predictions = model.predict(data[[x_col]])

    # ------------------------------------------------------------------
    # Step 4: Calculate model diagnostics
    # ------------------------------------------------------------------
    # Pearson correlation (r): how strongly x and y move together (-1 to 1)
    correlation = x.corr(y)

    # Mean Squared Error (MSE): average squared difference between actual and predicted y
    mse = mean_squared_error(y, predictions)

    # R-squared: fraction of variance in y explained by the model (0 to 1)
    r_squared = r2_score(y, predictions)

    # ------------------------------------------------------------------
    # Step 5: Build the scatter plot and overlay the regression line
    # ------------------------------------------------------------------
    plt.figure(figsize=(8, 6))
    plt.scatter(x, y, color="red", label="Observations", alpha=0.85)
    plt.plot(x, predictions, color="blue", linewidth=2, label="Regression line")

    # Show the equation and key statistics directly on the plot
    stats_text = (
        f"y = {slope:.2f}x + {intercept:.2f}\n"
        f"r = {correlation:.4f}\n"
        f"MSE = {mse:.2f}\n"
        f"R² = {r_squared:.4f}"
    )
    plt.text(
        x.min(),
        y.max() - 0.15 * (y.max() - y.min()),
        stats_text,
        fontsize=10,
        verticalalignment="top",
    )

    plt.title(f"Linear Regression: {y_col} vs {x_col}")
    plt.xlabel(x_col)
    plt.ylabel(y_col)
    plt.legend()
    plt.tight_layout()

    # ------------------------------------------------------------------
    # Step 6: Save the plot to a PNG file
    # ------------------------------------------------------------------
    output_file = "linear_regression_python_output.png"
    plt.savefig(output_file, dpi=150, bbox_inches="tight")
    plt.close()

    # ------------------------------------------------------------------
    # Step 7: Print diagnostics to the terminal
    # ------------------------------------------------------------------
    print("=" * 42)
    print("Linear Regression Results (Python)")
    print("=" * 42)
    print(f"Slope:        {slope:.4f}")
    print(f"Intercept:    {intercept:.4f}")
    print(f"Correlation:  {correlation:.4f}")
    print(f"MSE:          {mse:.2f}")
    print(f"R-squared:    {r_squared:.4f}")
    print(f"Plot saved:   {output_file}")


if __name__ == "__main__":
    main()
