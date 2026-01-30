#!/bin/bash

set -e

# Paths
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_SKILLS_DIR="$REPO_ROOT/skills"
GEMINI_GLOBAL_DIR="$HOME/.gemini"
DEST_SKILLS_DIR="$GEMINI_GLOBAL_DIR/skills"
JS_SCRIPT="$REPO_ROOT/.gemini/superpowers-gemini.js"

echo "Starting Gemini CLI Superpowers Installation..."

# 1. Install Skills
mkdir -p "$DEST_SKILLS_DIR"

echo "Installing skills..."
cp -R "$SOURCE_SKILLS_DIR/"* "$DEST_SKILLS_DIR/"
echo "Skills installed."

# 2. Run Bootstrap Logic (via Node.js script)
echo "Running bootstrap injection..."
if command -v node >/dev/null 2>&1; then
    node "$JS_SCRIPT" bootstrap
else
    echo "Error: Node.js is required but not found."
    exit 1
fi

echo "Installation Complete!"