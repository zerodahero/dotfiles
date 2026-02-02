#!/usr/bin/env bash
set -euo pipefail

# Check if Homebrew is installed
if ! type brew &> /dev/null; then
    echo "Homebrew is not installed. Please install Homebrew first."
    exit 1
fi

comment_pattern='/^#/d'

echo "Formulas"
sed $comment_pattern base-formulas | xargs brew install --dry-run --formula

echo "Casks"
sed $comment_pattern base-casks | xargs brew install --dry-run --cask

# Ask to confirm
read -p "Do you want to install these packages? (y/n): " answer
if [[ $answer != "y" ]]; then
    echo "Installation aborted."
    exit 1
fi

sed $comment_pattern base-formulas | xargs brew install --formula
sed $comment_pattern base-casks | xargs brew install --cask
