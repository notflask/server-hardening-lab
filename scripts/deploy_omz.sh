#!/bin/bash
USERS=("admin" "alice" "bob")
sudo apt update && sudo apt install zsh git curl -y
for USERNAME in "${USERS[@]}"; do
    sudo chsh -s $(which zsh) $USERNAME
    sudo su - $USERNAME -c 'RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'
    sudo cp configs/.zshrc_template /home/$USERNAME/.zshrc
    sudo chown $USERNAME:$USERNAME /home/$USERNAME/.zshrc
done
