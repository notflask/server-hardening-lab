# Server Hardening Lab

A comprehensive project focused on securing a Linux environment, implementing granular access control, and automating system administration tasks. This lab simulates a corporate infrastructure setup with a focus on security best practices.

## Project Objectives
The goal of this project was to transform a vanilla Ubuntu Server installation into a production-ready, hardened environment by:
* Implementing a secure user hierarchy and permission model.
* Hardening network access via SSH (key-based auth, non-standard port).
* Automating system monitoring and environment provisioning.
* Enhancing the developer experience (DX) with a unified Zsh configuration.

## Tech Stack
* **OS:** Ubuntu Server 26.04 LTS
* **Shell:** Zsh (Oh-My-Zsh)
* **Security:** OpenSSH, Systemd Sockets, Linux Permissions (POSIX)
* **Automation:** Bash Scripting, Cron

## Key Features & Implementation

### 1. Advanced User & Access Management
* **Hierarchical Structure:** Created dedicated groups (`sysadmins`, `devs`) and users with restricted privileges.
* **Shared Directory Security:** Configured `/company/dev_scripts` with a **Sticky Bit (`+t`)**, ensuring users can only delete their own files within a shared group folder.
* **Enforced Password Policies:** Used `chage` to force password rotation upon first login.

### 2. SSH Hardening (Zero-Trust Approach)
* **Port Remapping:** Moved SSH from port 22 to **2222** to reduce automated brute-force attacks.
* **Authentication:** Disabled password-based logins (`PasswordAuthentication no`) in favor of **Ed25519/RSA Public Key Authentication**.
* **Systemd Override:** Resolved Ubuntu's `ssh.socket` conflicts by implementing systemd unit overrides to ensure custom port persistence.

### 3. Automation & Monitoring
* **Audit Scripting:** Developed a Bash script to monitor active users and system uptime.
* **Scheduled Tasks:** Implemented **Cron jobs** for automated logging and system health checks.

## Project Structure
```text
.
├── scripts/
│   ├── setup_users.sh       # Automates groups, users, and directory tree
│   ├── harden_ssh.sh        # Configures SSHD and Systemd socket overrides
│   ├── deploy_omz.sh        # Mass-deploys Oh-My-Zsh for all users
│   └── sys_monitor.sh       # System audit script for Cron
├── install.sh # Installs everything together
└── README.md