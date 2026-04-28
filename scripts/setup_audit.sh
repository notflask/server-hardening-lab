#!/bin/bash
set -e

echo "[*] Installing auditd..."
sudo apt update
sudo apt install -y auditd audispd-plugins

echo "[*] Copying audit rules..."
sudo cp configs/audit.rules /etc/audit/rules.d/hardening.rules

echo "[*] Restarting auditd..."
sudo systemctl enable auditd
sudo systemctl restart auditd

echo "[+] Active audit rules:"
sudo auditctl -l
