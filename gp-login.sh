#!/bin/sh

# Set default XDG_CONFIG_HOME if not set
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
CONFIG_FILE="$XDG_CONFIG_HOME/globalprotect/config"

# Ensure config directory exists
mkdir -p "$XDG_CONFIG_HOME/globalprotect"

# If config file doesn't exist, prompt user to create it
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Username not found. Creating config file at $CONFIG_FILE."
  printf "Enter your GlobalProtect username: "
  read GP_USERNAME
  echo "GP_USERNAME=$GP_USERNAME" > "$CONFIG_FILE"
  echo "Config saved. Run the script again."
  exit 0
fi

# Load username from config file
GP_USERNAME=$(grep '^GP_USERNAME=' "$CONFIG_FILE" | cut -d '=' -f2)

# Check if username is still empty
if [ -z "$GP_USERNAME" ]; then
  echo "Error: No username found in $CONFIG_FILE" >&2
  exit 1
fi

# Keychain service name
KEYCHAIN_SERVICE="GlobalProtect"

# Retrieve password from macOS Keychain
PASSWORD=$(security find-generic-password -s "$KEYCHAIN_SERVICE" -w 2>/dev/null)

# If password isn't found, prompt the user to add it
if [ -z "$PASSWORD" ]; then
  echo "No password found in Keychain for $KEYCHAIN_SERVICE."
  printf "Enter your GlobalProtect password: "
  stty -echo
  read PASSWORD
  stty echo
  echo
  echo "Storing password in Keychain..."
  security add-generic-password -s "$KEYCHAIN_SERVICE" -a "$GP_USERNAME" -w "$PASSWORD"
  echo "Password saved. Running login now..."
fi

# Use osascript to autofill GlobalProtect login
osascript <<EOF
tell application "System Events"
    tell process "GlobalProtect"
        set frontmost to true
        delay 1
        keystroke "$GP_USERNAME"
        key code 48 -- Tab
        keystroke "$PASSWORD"
        key code 36 -- Enter
    end tell
end tell
EOF

