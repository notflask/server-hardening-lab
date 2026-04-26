#!/bin/bash
sudo groupadd -f devs
sudo groupadd -f sysadmins
sudo useradd -m -s /bin/bash alice 2>/dev/null || true
sudo useradd -m -s /bin/bash bob 2>/dev/null || true
sudo usermod -aG devs alice
sudo usermod -aG devs,sysadmins bob
sudo mkdir -p /company/dev_scripts
sudo mkdir -p /company/server_backups
sudo chown alice:devs /company/dev_scripts
sudo chown root:sysadmins /company/server_backups
sudo chmod u=rwx,g=rwx,o= /company/server_backups
sudo chmod u=rwx,g=rwx,o= /company/dev_scripts
sudo chmod +t /company/dev_scripts
