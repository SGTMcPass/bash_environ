#!/bin/bash

# treeignore_script.sh
# Description: Runs the tree command while respecting a .treeignore file
# Usage: ./treeignore_script.sh [directory]
# If no directory is specified, it defaults to the current directory.

# Set the target directory
TARGET_DIR=${1:-.}

# Check if .treeignore exists in the target directory
TREEIGNORE_PATH="$TARGET_DIR/.treeignore"

# If no .treeignore is found, just run tree
if [ ! -f "$TREEIGNORE_PATH" ]; then
  echo ".treeignore not found in the target directory, running tree normally."
  tree "$TARGET_DIR"
  exit 0
fi

# Read .treeignore, filter out comments and empty lines, remove trailing slashes, and format for tree
IGNORE_PATTERN=$(grep -v '^#' "$TREEIGNORE_PATH" | grep -v '^$' | sed 's#/$##' | tr '\n' '|' | sed 's/|$//')

# If no patterns are found, just run tree normally
if [ -z "$IGNORE_PATTERN" ]; then
  tree "$TARGET_DIR"
else
  tree "$TARGET_DIR" -I "$IGNORE_PATTERN"
fi

