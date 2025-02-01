# GlobalProtect Auto-Login Script

## 📌 Overview

This script automates the login process for **GlobalProtect VPN** on macOS. Instead of manually entering credentials every time, it **securely retrieves your password from macOS Keychain** and **autofills** the login fields using AppleScript. If no password is found, the script **prompts you to enter and store it** securely.

## 🛠 The Problem

GlobalProtect on macOS has an annoying floating login window that:

- **Prevents macOS password autofill** from working.
    
- **Blocks Keychain autofill**, making you manually open Keychain and copy-paste your password.
    
- **Forces repetitive login steps** every time you need VPN access.
    

This script **completely eliminates** these issues by:

✅ **Storing your credentials securely in Keychain** (without hardcoding passwords).  
✅ **Automatically filling in your username and password** every time you log in.  
✅ **Following XDG standards**, keeping your system clean and organized.

## 🚀 Installation

Run the following commands:

```
chmod +x install.zsh
./install.zsh
```

This will:

- Ensure `$XDG_BIN_HOME` exists (defaults to `~/.local/bin`).
    
- **Symlink** `gp-login.zsh` to `$XDG_BIN_HOME/gp-login`.
    
- Add `$XDG_BIN_HOME` to your `PATH` if missing.
    

## 🏃 Usage

Once installed, just run:

```
gp-login
```

The first time you run it, the script will:

1. **Ask for your GlobalProtect username** (stored in `~/.config/globalprotect/config`).
    
2. **Ask for your password** and store it in **macOS Keychain**.
    
3. **Automate the login process** using AppleScript.
    

Next time, just run `gp-login` and it will **log you in automatically**!

## 🔒 Security

- **No passwords are stored in plain text.**
    
- Uses **macOS Keychain** for safe password storage.
    
- Fully **XDG-compliant**, keeping your config in `~/.config` and scripts in `~/.local/bin`.
    

## 🛠 Troubleshooting

- If the password is missing or incorrect, **remove it from Keychain** and re-run `gp-login`:
    
    ```
    security delete-generic-password -s "GlobalProtect"
    ```
    
- If `gp-login` isn’t found, ensure `$XDG_BIN_HOME` is in your `PATH`:
    
    ```
    export PATH="$HOME/.local/bin:$PATH"
    ```
    
- If GlobalProtect window names change, adjust the **AppleScript** inside `gp-login.zsh`.
    

## 📜 License

MIT License. Use at your own risk. No warranty provided.

Enjoy hassle-free VPN logins! 🚀
