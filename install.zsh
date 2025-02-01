#!/bin/zsh

# Set default XDG paths
XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"

# Ensure the bin directory exists
mkdir -p "$XDG_BIN_HOME"

# Get the script's directory (assumes the script is in the same dir as this installer)
SCRIPT_DIR="$(cd -- "$(dirname -- "${(%):-%N}")" && pwd)"
SCRIPT_PATH="$SCRIPT_DIR/gp-login.zsh"

# Ensure the script exists before linking
if [[ ! -f "$SCRIPT_PATH" ]]; then
  echo "Error: gp-login.zsh not found in $SCRIPT_DIR!" >&2
  exit 1
fi

# Create symlink in XDG_BIN_HOME
ln -sf "$SCRIPT_PATH" "$XDG_BIN_HOME/gp-login"

# Ensure XDG_BIN_HOME is in PATH
if [[ ":$PATH:" != *":$XDG_BIN_HOME:"* ]]; then
  echo "export PATH=\"$XDG_BIN_HOME:\$PATH\"" >> "$HOME/.zshrc"
  echo "Added $XDG_BIN_HOME to PATH. Restart terminal or run: source ~/.zshrc"
fi

echo "✅ Installed! You can now run 'gp-login' from anywhere."
