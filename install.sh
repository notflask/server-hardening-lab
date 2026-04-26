#!/bin/bash
echo "Starting Full Server Hardening..."
bash scripts/setup_users.sh
bash scripts/harden_ssh.sh
bash scripts/deploy_omz.sh
echo "System is now hardened and ready!"