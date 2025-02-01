#!/bin/sh

# Set default XDG_BIN_HOME if not set
XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
SCRIPT_NAME="gp-login"
SCRIPT_PATH="$(pwd)/gp-login.sh"
INSTALL_PATH="$XDG_BIN_HOME/$SCRIPT_NAME"

# Ensure the bin directory exists
mkdir -p "$XDG_BIN_HOME"

# Check if script exists
if [ ! -f "$SCRIPT_PATH" ]; then
  echo "❌ Error: $SCRIPT_NAME script not found in $(pwd)" >&2
  exit 1
fi

# Ask before overwriting symlink
if [ -e "$INSTALL_PATH" ] || [ -L "$INSTALL_PATH" ]; then
  echo "⚠️  $INSTALL_PATH already exists. Overwrite? [y/N]"
  read -r confirm
  if [ "$confirm" != "y" ]; then
    echo "Installation cancelled."
    exit 1
  fi
fi

# Create symlink
ln -sf "$SCRIPT_PATH" "$INSTALL_PATH"
echo "✅ Installed $SCRIPT_NAME to $INSTALL_PATH"

# Check if XDG_BIN_HOME is in PATH
if ! echo "$PATH" | grep -q "$XDG_BIN_HOME"; then
  echo "⚠️  $XDG_BIN_HOME is not in your PATH."
  echo "➡️  Add it manually by running:"
  echo "    echo 'export PATH=\"$XDG_BIN_HOME:\$PATH\"' >> ~/.zshrc"
  echo "    source ~/.zshrc"
fi

# Success message
echo "🚀 Done! Run '$SCRIPT_NAME' to start."
