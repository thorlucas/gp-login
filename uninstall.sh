#!/bin/sh

XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
SCRIPT_NAME="gp-login"
INSTALL_PATH="$XDG_BIN_HOME/$SCRIPT_NAME"

if [ -L "$INSTALL_PATH" ]; then
  echo "🗑️  Removing $SCRIPT_NAME from $INSTALL_PATH"
  rm "$INSTALL_PATH"
else
  echo "❌ Error: $SCRIPT_NAME not found in $INSTALL_PATH"
  exit 1
fi

echo "✅ Uninstall complete."
