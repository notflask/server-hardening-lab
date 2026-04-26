#!/bin/bash
sudo cp configs/sshd_config /etc/ssh/sshd_config
sudo chown root:root /etc/ssh/sshd_config
sudo chmod 644 /etc/ssh/sshd_config
if [ -f "/etc/ssh/sshd_config.d/50-cloud-init.conf" ]; then
    sudo sed -i "s/PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config.d/50-cloud-init.conf
fi
sudo mkdir -p /etc/systemd/system/ssh.socket.d/
cat <<EOF | sudo tee /etc/systemd/system/ssh.socket.d/listen.conf
[Socket]
ListenStream=
ListenStream=2222
EOF
sudo systemctl daemon-reload
sudo systemctl restart ssh.socket
sudo systemctl restart ssh
