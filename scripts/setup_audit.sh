#!/bin/bash
# setup_audit.sh
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "[*] Installing auditd..."
sudo apt update
sudo apt install -y auditd audispd-plugins

echo "[*] Copying audit rules..."
RULES_SRC="$PROJECT_ROOT/configs/audit.rules"
if [ -f "$RULES_SRC" ]; then
    sudo cp "$RULES_SRC" /etc/audit/rules.d/hardening.rules
else
    echo "[!] Error: audit.rules not found at $RULES_SRC"
    exit 1
fi

echo "[*] Restarting auditd..."
sudo systemctl enable auditd
sudo systemctl restart auditd

echo "[+] Active audit rules:"
sudo auditctl -l
