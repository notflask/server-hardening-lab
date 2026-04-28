#!/bin/bash
set -e

echo "[*] Firewall will be configured..."

sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow 2222/tcp comment 'SSH (non-standard port)'
sudo ufw allow 80/tcp comment 'HTTP'
sudo ufw allow 443/tcp comment 'HTTPS'

sudo ufw --force enable

echo "[+] Firewall status:"
sudo ufw status verbose
