#!/bin/bash
# run_lin_reg.sh
# Runs both the Python and R linear regression scripts, then exports notebooks to HTML.

set -e

if [ "$#" -ne 3 ]; then
  echo "Usage: bash run_lin_reg.sh <filename> <x_column> <y_column>"
  echo "Example: bash run_lin_reg.sh regression_data.csv YearsExperience Salary"
  exit 1
fi

FILENAME="$1"
X_COLUMN="$2"
Y_COLUMN="$3"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "======================================"
echo "Running Python linear regression..."
echo "======================================"
python python_lin_reg.py "$FILENAME" "$X_COLUMN" "$Y_COLUMN"

echo ""
echo "======================================"
echo "Running R linear regression..."
echo "======================================"
Rscript r_lin_reg.r "$FILENAME" "$X_COLUMN" "$Y_COLUMN"

echo ""
echo "======================================"
echo "Exporting notebooks to HTML..."
echo "======================================"
if command -v jupyter >/dev/null 2>&1; then
  jupyter nbconvert --to html python_lin_reg.ipynb
  jupyter nbconvert --to html r_lin_reg.ipynb
else
  echo "jupyter not found; skipping HTML export."
fi

echo ""
echo "Done."
echo "Created:"
echo "  - linear_regression_python_output.png"
echo "  - linear_regression_r_output.png"
if command -v jupyter >/dev/null 2>&1; then
  echo "  - python_lin_reg.html"
  echo "  - r_lin_reg.html"
fi
