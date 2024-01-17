#!/bin/bash

# Symlink
    # Check for and create parent directories if they do not exist
mkdir -p ~/.aws
mkdir -p ~/.config/starship
mkdir -p ~/.config/nvim

mkdir -p ~/.zsh
mkdir -p ~/.ssh

mkdir -p ~/.config/nvim/lua
mkdir -p ~/.config/nvim/lua/plugins/configs
mkdir -p ~/.config/nvim/lua/plugins
mkdir -p ~/.config/nvim/lua/core

    # Create symbolic links
ln -s ~/.dotfiles/.config/nvim/.gitignore ~/.config/nvim/.gitignore
ln -s ~/.dotfiles/.config/nvim/.ignore ~/.config/nvim/.ignore
ln -s ~/.dotfiles/.config/nvim/.stylua.toml ~/.config/nvim/.stylua.toml

# lua directory
ln -s ~/.dotfiles/.config/nvim/lua/core ~/.config/nvim/lua/core
ln -s ~/.dotfiles/.config/nvim/lua/plugins ~/.config/nvim/lua/plugins

# Subdirectories and files inside lua/core
ln -s ~/.dotfiles/.config/nvim/lua/core/bootstrap.lua ~/.config/nvim/lua/core/bootstrap.lua
ln -s ~/.dotfiles/.config/nvim/lua/core/default_config.lua ~/.config/nvim/lua/core/default_config.lua
ln -s ~/.dotfiles/.config/nvim/lua/core/init.lua ~/.config/nvim/lua/core/init.lua
ln -s ~/.dotfiles/.config/nvim/lua/core/mappings.lua ~/.config/nvim/lua/core/mappings.lua
ln -s ~/.dotfiles/.config/nvim/lua/core/utils.lua ~/.config/nvim/lua/core/utils.lua

# Subdirectories and files inside lua/plugins
ln -s ~/.dotfiles/.config/nvim/lua/plugins/init.lua ~/.config/nvim/lua/plugins/init.lua
ln -s ~/.dotfiles/.config/nvim/lua/plugins/configs ~/.config/nvim/lua/plugins/configs

ln -s ~/.dotfiles/.aws/config ~/.aws/config
ln -s ~/.dotfiles/.config/starship/starship.toml ~/.config/starship/starship.toml
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.ssh/config ~/.ssh/config
ln -s ~/.dotfiles/.zsh/aliases.zsh ~/.zsh/aliases.zsh
ln -s ~/.dotfiles/.zsh/functions.zsh ~/.zsh/functions.zsh
ln -s ~/.dotfiles/.zsh/keybinds.zsh ~/.zsh/keybinds.zsh
ln -s ~/.dotfiles/.zsh/starship.zsh ~/.zsh/starship.zsh
ln -s ~/.dotfiles/.zsh/wsl2fix.zsh ~/.zsh/wsl2fix.zsh
ln -s ~/.dotfiles/.zshenv ~/.zshenv
ln -s ~/.dotfiles/.zshrc ~/.zshrc


# Update
echo -e "\033[1;34mUpdating and upgrading system...\033[0m"
sudo apt update && apt sudo upgrade -y
echo -e "\033[1;34m...Done!\033[0m"


# Install
echo -e "\033[1;34mInstalling essentials...\033[0m"
sudo apt install -y curl build-essential libc-dev cmake fzf ripgrep tar 
echo -e "\033[1;34m...Done!\033[0m"


# Docker
echo -e "\033[1;34mDocerconfig...\033[0m"
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt remove $pkg; done
    # Add Docker's official GPG key:
sudo apt update
sudo apt install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

    # Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
    # Install Docler packages
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Shell
echo -e "\033[1;34mShell config...\033[0m"
sudo apt install -y zsh
curl -sS https://starship.rs/install.sh | sh
starship preset gruvbox-rainbow -o ~/.config/starship/starship.toml
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.zsh}/plugins/zsh-syntax-highlighting
chsh -s $(which zsh)
echo -e "\033[1;34m...Done!\033[0m"

# Neovim
sudo apt install -y fuse
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
nvim --headless "+Lazy! sync" +qa
