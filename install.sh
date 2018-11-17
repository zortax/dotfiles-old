#!/bin/bash

USER=$(whoami)
INSTALL_PATH=$(pwd)

# ZSH

if [ -d "/home/$USER/.oh-my-zsh" ] then
    echo "Oh-My-Zsh is already installed. Skipping..."
else
    echo "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

echo "Installing .zshrc..."
if [ -f "/home/$USER/.zshrc" ] then
    mv /home/$USER/.zshrc /home/$USER/.zshrc.bak
fi
ln -s $INSTALL_PATH/zsh/.zshrc /home/$USER/.zshrc

