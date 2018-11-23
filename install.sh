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

# i3

if [ -d $USER_PATH/.config/i3/ ]; then
    if [ -f "$USER_PATH/.config/i3/config" ]; then
        echo "Backing up old i3 config..."
        mv $USER_PATH/.config/i3/config $USER_PATH/.config/i3/config.bak
    fi
else
    mkdir $USER_PATH/.config/i3
fi

echo "Installing i3 config..."
ln -s $INSTALL_PATH/i3/config $USER_PATH/.config/i3/config

# i3status

if [ -d "$USER_PATH/.config/i3status/" ]; then
    if [ -f "$USER_PATH/.config/i3status/config" ]; then
        echo "Backing up old i3status config..."
        mv $USER_PATH/.config/i3status/config $USER_PATH/.config/i3status/config.bak
    fi
else
    mkdir $USER_PATH/.config/i3status
fi

echo "Installing i3status config..."
ln -s $INSTALL_PATH/i3/i3status $USER_PATH/.config/i3status/config

# gtk-3.0

if [ -d "/usr/share/themes/Vimix-Midnight" ]; then
    echo "Backing up already installed version of Vimix-Midnight..."
    sudo mv /usr/share/themes/Vimix-Midnight /usr/share/Vimix-Midnight_old
fi

echo "Installing Vimix-Midnight..."
sudo ln -s $INSTALL_PATH/gtk-3.0/themes/Vimix-Midnight/ /usr/share/themes/Vimix-Midnight

if [ -d "$USER_PATH/.config/gtk-3.0" ]; then
    if [ -f "$USER_PATH/.config/gtk-3.0/settings.ini" ]; then
        echo "Backing up old gtk-3.0 settings.ini..."
        mv $USER_PATH/.config/gtk-3.0/settings.ini $USER_PATH/.config/gtk-3.0/settings.ini.bak
    fi
else
    mkdir $USER_PATH/.config/gtk-3.0
fi

echo "Installing gtk-3.0 settings.ini..."
ln -s $INSTALL_PATH/gtk-3.0/settings.ini $USER_PATH/.config/gtk-3.0/settings.ini

