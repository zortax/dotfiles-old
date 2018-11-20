#!/bin/bash

USER=$(whoami)
INSTALL_PATH=$(pwd)
USER_PATH=/home/$USER

if [[ $USER == "root" ]]; then
    USER_PATH=/root
fi

# ZSH

if [ -d "$USER_PATH/.oh-my-zsh/" ]; then
    echo "Oh-My-Zsh is already installed. Skipping..."
else
    echo "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ -f "$USER_PATH/.zshrc" ]; then
    echo "Backing up old .zshrc..."
    mv $USER_PATH/.zshrc $USER_PATH/.zshrc.bak
fi
echo "Installing .zshrc..."
ln -s $INSTALL_PATH/zsh/.zshrc $USER_PATH/.zshrc

# Neovim
INSTALLED="false"
if [ -d $USER_PATH/.local/share/nvim/site/autoload/ ]; then
    if [ -f $USER_PATH/.local/share/nvim/site/autoload/plug.vim ]; then
        echo "Vim-Plug is already installed for Neovim. Skipping..."
        INSTALLED="true"
    fi
fi

if [[ $INSTALLED == "false" ]]; then
    echo "Installing Vim-Plug for Neovim..."
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ -d "$USER_PATH/.config/nvim/" ]; then
    if [ -f "$USER_PATH/.config/nvim/init.vim" ]; then
        echo "Backing up old init.vim..."
        mv $USER_PATH/.config/nvim/init.vim $USER_PATH/.config/nvim/init.vim.bak
    fi
else
    mkdir $USER_PATH/.config/nvim
fi

echo "Installing init.vim..."
ln -s $INSTALL_PATH/nvim/init.vim $USER_PATH/.config/nvim/init.vim

