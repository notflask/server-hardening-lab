#!/bin/bash
set -e

echo "[*] Installing fail2ban..."
sudo apt update
sudo apt install -y fail2ban

echo "[*] Coyping configuraton..."
sudo cp configs/jail.local /etc/fail2ban/jail.local

echo "[*] Restart fail2ban..."
sudo systemctl enable fail2ban
sudo systemctl restart fail2ban

echo "[+] fail2ban status:"
sudo fail2ban-client status
