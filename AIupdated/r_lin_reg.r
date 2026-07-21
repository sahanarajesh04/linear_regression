#!/usr/bin/env Rscript
# Linear Regression Analysis (Assignment 3, Part A) — AI-Enhanced R Script
#
# This script:
#   1. Reads a CSV file
#   2. Makes a scatter plot of two columns
#   3. Fits a simple linear regression model
#   4. Overlays the regression line on the plot
#   5. Prints model diagnostics (slope, intercept, correlation, MSE, R-squared)
#   6. Saves the plot as a PNG file
#
# Usage:
#   Rscript r_lin_reg.r <filename> <x_column> <y_column>
#
# Example:
#   Rscript r_lin_reg.r regression_data.csv YearsExperience Salary

# ------------------------------------------------------------------
# Step 1: Read command-line arguments
# ------------------------------------------------------------------
args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 3) {
  cat("Usage: Rscript r_lin_reg.r <filename> <x_column> <y_column>\n")
  cat("Example: Rscript r_lin_reg.r regression_data.csv YearsExperience Salary\n")
  quit(status = 1)
}

filename <- args[1]
x_col <- args[2]
y_col <- args[3]

# ggplot2 is used for the scatter plot and regression line
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  stop("ggplot2 is required. Install it with install.packages('ggplot2').")
}

# ------------------------------------------------------------------
# Step 2: Load the CSV into a data frame (R's version of a table)
# ------------------------------------------------------------------
if (!file.exists(filename)) {
  stop(paste("Error: file not found:", filename))
}

data <- read.csv(filename)

if (!(x_col %in% names(data)) || !(y_col %in% names(data))) {
  stop(paste("Error: columns must be one of", paste(names(data), collapse = ", ")))
}

# ------------------------------------------------------------------
# Step 3: Fit a linear regression model
# lm() finds the best straight line: y = slope * x + intercept
# ------------------------------------------------------------------
formula <- as.formula(paste(y_col, "~", x_col))
model <- lm(formula, data = data)

slope <- coef(model)[2]
intercept <- coef(model)[1]
predictions <- predict(model, newdata = data)

# ------------------------------------------------------------------
# Step 4: Calculate model diagnostics
# ------------------------------------------------------------------
# Pearson correlation (r): how strongly x and y move together
correlation <- cor(data[[x_col]], data[[y_col]])

# Mean Squared Error (MSE): average squared difference between actual and predicted y
mse <- mean((data[[y_col]] - predictions)^2)

# R-squared: fraction of variance in y explained by the model
r_squared <- summary(model)$r.squared

# ------------------------------------------------------------------
# Step 5: Build the scatter plot and overlay the regression line
# ------------------------------------------------------------------
stats_label <- paste0(
  "y = ", round(slope, 2), "x + ", round(intercept, 2),
  "\nr = ", round(correlation, 4),
  "\nMSE = ", round(mse, 2),
  "\nR² = ", round(r_squared, 4)
)

plot <- ggplot2::ggplot(data, ggplot2::aes(x = .data[[x_col]], y = .data[[y_col]])) +
  ggplot2::geom_point(color = "red", alpha = 0.85) +
  ggplot2::geom_line(
    ggplot2::aes(y = predictions),
    color = "blue",
    linewidth = 1
  ) +
  ggplot2::annotate(
    "text",
    x = min(data[[x_col]]),
    y = max(data[[y_col]]) - 0.15 * (max(data[[y_col]]) - min(data[[y_col]])),
    label = stats_label,
    hjust = 0,
    size = 3.5
  ) +
  ggplot2::labs(
    title = paste("Linear Regression:", y_col, "vs", x_col),
    x = x_col,
    y = y_col
  ) +
  ggplot2::theme_minimal()

# ------------------------------------------------------------------
# Step 6: Save the plot to a PNG file
# ------------------------------------------------------------------
output_file <- "linear_regression_r_output.png"
ggplot2::ggsave(output_file, plot = plot, width = 8, height = 6, dpi = 150)

# ------------------------------------------------------------------
# Step 7: Print diagnostics to the terminal
# ------------------------------------------------------------------
cat("==========================================\n")
cat("Linear Regression Results (R)\n")
cat("==========================================\n")
cat("Slope:       ", round(slope, 4), "\n", sep = "")
cat("Intercept:   ", round(intercept, 4), "\n", sep = "")
cat("Correlation: ", round(correlation, 4), "\n", sep = "")
cat("MSE:         ", round(mse, 2), "\n", sep = "")
cat("R-squared:   ", round(r_squared, 4), "\n", sep = "")
cat("Plot saved:  ", output_file, "\n", sep = "")
