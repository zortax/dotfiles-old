#!/bin/bash

USER=$(whoami)
INSTALL_PATH=$(pwd)

# ZSH

if [ -d "/home/$USER/.oh-my-zsh/" ]; then
    echo "Oh-My-Zsh is already installed. Skipping..."
else
    echo "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ -f "/home/$USER/.zshrc" ]; then
    echo "Backing up old .zshrc..."
    mv /home/$USER/.zshrc /home/$USER/.zshrc.bak
fi
echo "Installing .zshrc..."
ln -s $INSTALL_PATH/zsh/.zshrc /home/$USER/.zshrc

# Neovim

echo "Installing init.vim..."

if [ -d "/home/$USER/.config/nvim/" ]; then
    if [ -f "/home/$USER/.config/nvim/init.vim" ]; then
        echo "Backing up old init.vim..."
        mv /home/$USER/.config/nvim/init.vim /home/$USER/.config/nvim/init.vim.bak
    fi
else
    mkdir /home/$USER/.config/nvim
fi
ln -s $INSTALL_PATH/nvim/init.vim /home/$USER/.config/nvim/init.vim

