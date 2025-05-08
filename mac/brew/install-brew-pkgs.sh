#!/usr/bin/env bash
set -euo pipefail

# Check if Homebrew is installed
if ! type brew &> /dev/null; then
    echo "Homebrew is not installed. Please install Homebrew first."
    exit 1
fi

echo "Formulas"
cat base-formulas | xargs brew install --dry-run --formula

echo "Casks"
cat base-casks | xargs brew install --dry-run --cask

# Ask to confirm
read -p "Do you want to install these packages? (y/n): " answer
if [[ $answer != "y" ]]; then
    echo "Installation aborted."
    exit 1
fi

cat base-formulas | xargs brew install --formula
cat base-casks | xargs brew install --cask
