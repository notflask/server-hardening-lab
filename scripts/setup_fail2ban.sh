#!/bin/bash
# setup_fail2ban.sh
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "[*] Installing fail2ban..."
sudo apt update
sudo apt install -y fail2ban

echo "[*] Copying configuration..."
CONFIG_SRC="$PROJECT_ROOT/configs/jail.local"
if [ -f "$CONFIG_SRC" ]; then
    sudo cp "$CONFIG_SRC" /etc/fail2ban/jail.local
else
    echo "[!] Error: jail.local not found at $CONFIG_SRC"
    exit 1
fi

echo "[*] Restarting fail2ban..."
sudo systemctl enable fail2ban
sudo systemctl restart fail2ban

echo "[+] fail2ban status:"
sudo fail2ban-client status
