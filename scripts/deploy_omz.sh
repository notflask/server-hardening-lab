#!/bin/bash
# deploy_omz.sh - Install Oh-My-Zsh for lab users

# Get the absolute path to the project root
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

USERS=("alice" "bob")

echo "[*] Updating packages and installing dependencies..."
sudo apt update && sudo apt install zsh git curl -y

for USERNAME in "${USERS[@]}"; do
    if ! id "$USERNAME" &>/dev/null; then
        echo "[!] User $USERNAME does not exist, skipping..."
        continue
    fi

    echo "[*] Configuring Oh-My-Zsh for $USERNAME..."
    
    # Change shell to zsh
    sudo chsh -s $(which zsh) "$USERNAME"

    # Install Oh-My-Zsh if not already present
    if [ ! -d "/home/$USERNAME/.oh-my-zsh" ]; then
        sudo -u "$USERNAME" sh -c 'RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'
    else
        echo "[*] Oh-My-Zsh already installed for $USERNAME"
    fi

    # Deploy custom .zshrc
    ZSHRC_TEMPLATE="$PROJECT_ROOT/configs/.zshrc-template"
    if [ -f "$ZSHRC_TEMPLATE" ]; then
        sudo cp "$ZSHRC_TEMPLATE" "/home/$USERNAME/.zshrc"
        sudo chown "$USERNAME:$USERNAME" "/home/$USERNAME/.zshrc"
        echo "[+] Deployed .zshrc for $USERNAME"
    else
        echo "[!] Error: .zshrc-template not found at $ZSHRC_TEMPLATE"
    fi
done
