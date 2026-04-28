#!/bin/bash
sudo groupadd -f devs
sudo groupadd -f sysadmins

# Create users if they don't exist
sudo useradd -m -s /bin/bash alice 2>/dev/null || true
sudo useradd -m -s /bin/bash bob 2>/dev/null || true

# Set default passwords and force change on next login
echo "alice:DefaultPassword123!" | sudo chpasswd
echo "bob:DefaultPassword123!" | sudo chpasswd
sudo chage -d 0 alice
sudo chage -d 0 bob

# Ensure group memberships
sudo usermod -aG devs alice
sudo usermod -aG devs,sysadmins bob

# Shared directories
sudo mkdir -p /company/dev_scripts
sudo mkdir -p /company/server_backups
sudo chown alice:devs /company/dev_scripts
sudo chown root:sysadmins /company/server_backups
sudo chmod u=rwx,g=rwx,o= /company/server_backups
sudo chmod u=rwx,g=rwx,o= /company/dev_scripts
sudo chmod +t /company/dev_scripts
