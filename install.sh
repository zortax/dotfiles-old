#!/bin/bash

USER=$(whoami)
INSTALL_PATH=$(pwd)
USER_PATH=/home/$USER

if [[ $USER == "root" ]]; then
    USER_PATH=/root
fi

ask() {
    while true; do
        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi
        read -p "$1 [$prompt] " REPLY </dev/tty
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac
    done
}

# Submodules

echo "Updating submodules..."
git submodule update --recursive --remote

# ZSH

if ask "Install .zshrc?" Y; then
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
fi

# .p10k.zsh

if ask "Install .p10k.zsh?" Y; then
    if [ -f "$USER_PATH/.p10k.zsh" ]; then
        echo "Backing up old .p10k.zsh..."
        mv $USER_PATH/.p10k.zsh $USER_PATH/.p10k.zsh.bak
    fi
    echo "Installing .p10k.zsh..."
    ln -s $INSTALL_PATH/zsh/.p10k.zsh $USER_PATH/.p10k.zsh
fi

# Neovim

if ask "Install Neovim configuration?" Y; then
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
fi

# i3

if ask "Install i3 configuration?" Y; then
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
fi

# i3status

if ask "Install i3status configuration?" Y; then
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
fi

# gtk-3.0
if ask "Install Vimix-Midnight gtk theme and configuration?" Y; then
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
        if [ -f "$USER_PATH/.config/gtk-3.0/gtk.css" ]; then
            echo "Backing up old gtk.css..."
            mv $USER_PATH/.config/gtk-3.0/gtk.css $USER_PATH/.config/gtk-3.0/gtk.css.bak
        fi
    else
        mkdir $USER_PATH/.config/gtk-3.0
    fi

    echo "Installing gtk-3.0 settings.ini..."
    ln -s $INSTALL_PATH/gtk-3.0/settings.ini $USER_PATH/.config/gtk-3.0/settings.ini

    echo "Installing gtk-3.0 gtk.css..."
    ln -s $INSTALL_PATH/gtk-3.0/gtk.css $USER_PATH/.config/gtk-3.0/gtk.css
fi

# polybar

if ask "Install polybar configuration?" Y; then
    if [ -d "$USER_PATH/.config/polybar/" ]; then
        if [ -f "$USER_PATH/.config/polybar/config" ]; then
            echo "Backing up old polybar config..."
            mv $USER_PATH/.config/polybar/config $USER_PATH/.config/polybar/config.bak
        fi
        if [ -f "$USER_PATH/.config/polybar/launch.sh" ]; then
            echo "Backing up old polybar launch.sh..."
            mv $USER_PATH/.config/polybar/launch.sh $USER_PATH/.config/polybar/launch.sh.bak
        fi
    else
        mkdir $USER_PATH/.config/polybar
    fi

    echo "Installing polybar config..."
    ln -s $INSTALL_PATH/polybar/config $USER_PATH/.config/polybar/config

    echo "Installing polybar launch.sh..."
    ln -s $INSTALL_PATH/polybar/launch.sh $USER_PATH/.config/polybar/launch.sh
fi

# compton

if ask "Install compton configuration?" Y; then
    if [ -f "$USER_PATH/.config/compton.conf" ]; then
        echo "Backing up old compton.conf...";
        mv $USER_PATH/.config/compton.conf $USER_PATH/.config/compton.conf.bak
    fi

    echo "Installing compton.conf..."
    ln -s $INSTALL_PATH/compton/compton.conf $USER_PATH/.config/compton.conf
fi

# gnome terminal

if ask "Install gnome-terminal settings profile?" Y; then
    echo "Installing gnome-terminal settings profile (select it manually)..."
    dconf load /org/gnome/terminal/legacy/profiles:/:ae3279f6-1440-4c3a-8fab-9db4a4fc777b/ < gnome-terminal/vimix-midnight-profile.dconf
fi

# Scripts

if ask "Install scripts (needed by polybar configuration)?" Y; then
    if [ -d "$USER_PATH/.scripts" ]; then
        echo "Backing up old .scripts directory...";
        mv $USER_PATH/.scripts $USER_PATH/.scripts_old
    fi

    echo "Installing scripts..."
    ln -s $INSTALL_PATH/scripts/ $USER_PATH/.scripts
fi

# ncmpcpp

if ask "Install ncmpcpp config?" Y; then
    if [ -d "$USER_PATH/.ncmpcpp" ]; then
        if [ -f "$USER_PATH/.ncmpcpp/config" ]; then
            echo "Backing up old ncmpcpp config..."
            mv $USER_PATH/.ncmpcpp/config $USER_PATH/.ncmpcpp/config.bak
        fi
    else
        mkdir $USER_PATH/.ncmpcpp
    fi
    echo "Installing ncmpcpp config..."
    ln -s $INSTALL_PATH/ncmpcpp/config $USER_PATH/.ncmpcpp/config
fi

# mopidy

if [ -f "$USER_PATH/.config/mopidy/mopidy.conf" ]; then
    echo "Skipping mopidy conf as there already is one in the target directory. This config needs manual editing (Spotify credentials). Backup the old config manually and run this script again if you want to (re-) install the config."
else
    if ask "Install mopidy.conf?" Y; then
        if [ ! -d "$USER_PATH/.config/mopidy" ]; then
            mkdir $USER_PATH/.config/mopidy
        fi
        echo "Installing mopidy.conf..."
        cp $INSTALL_PATH/ncmpcpp/mopidy.conf $USER_PATH/.config/mopidy/mopidy.conf
    fi
fi

# bspwm

if ask "Install bspwm config?" Y; then
    if [ -d "$USER_PATH/.config/bspwm" ]; then
        if [ -f "$USER_PATH/.config/bspwm/bspwmrc" ]; then
            echo "Backing up old bspwmrc..."
            mv $USER_PATH/.config/bspwm/bspwmrc $USER_PATH/.config/bspwm/bspwmrc.bak
        fi
    else
        mkdir $USER_PATH/.config/bspwm
    fi
    echo "Installing bspwm config..."
    ln -s $INSTALL_PATH/bspwm/bspwmrc $USER_PATH/.config/bspwm/bspwmrc
fi

# sxhkd

if ask "Install sxhkd config?" Y; then
    if [ -d "$USER_PATH/.config/sxhkd" ]; then
        if [ -f "$USER_PATH/.config/sxhkd/sxhkdrc" ]; then
            echo "Backing up old sxhkd config..."
            mv $USER_PATH/.config/sxhkd/sxhkdrc $USER_PATH/.config/sxhkd/sxhkdrc.bak
        fi
    else
        mkdir $USER_PATH/.config/sxhkd
    fi
    echo "Installing sxhkd config..."
    ln -s $INSTALL_PATH/sxhkd/sxhkdrc $USER_PATH/.config/sxhkd/sxhkdrc
fi

# rofi

if ask "Install rofi config?" Y; then
    if [ -d "$USER_PATH/.config/rofi" ]; then
        if [ -f "$USER_PATH/.config/rofi/config" ]; then
            echo "Backing up old rofi config..."
            mv $USER_PATH/.config/rofi/config.rasi $USER_PATH/.config/rofi/config.rasi.bak
        fi
        if [ -f "$USER_PATH/.config/rofi/rofi-dark-custom.rasi" ]; then
            echo "Backing up old rofi-dark-custom theme...";
            mv $USER_PATH/.config/rofi/rofi-dark-custom.rasi $USER_PATH/.config/rofi/rofi-dark-custom.rasi.bak
        fi
    else
        mkdir $USER_PATH/.config/rofi
    fi
    echo "Installing rofi config..."
    ln -s $INSTALL_PATH/rofi/config.rasi $USER_PATH/.config/rofi/config.rasi
    echo "Installing rofi-dark-custom theme..."
    ln -s $INSTALL_PATH/rofi/rofi-dark-custom.rasi $USER_PATH/.config/rofi/rofi-dark-custom.rasi
fi

# urxvt

if ask "Install urxvt config?" Y; then
    if [ -f "$USER_PATH/.Xdefaults" ]; then
        echo "Backing up old urxvt config..."
        mv $USER_PATH/.Xdefaults $USER_PATH/.Xdefaults.bak
    fi
    echo "Installing urxvt config..."
    ln -s $INSTALL_PATH/urxvt/.Xdefaults $USER_PATH/.Xdefaults
fi

# vim

if ask "Install vim config?" Y; then
    if [ -d "$USER_PATH/." ]; then
        if [ -f "$USER_PATH/./.vimrc" ]; then
            echo "Backing up old vim config..."
            mv $USER_PATH/./.vimrc $USER_PATH/./.vimrc.bak
        fi
    else
        mkdir $USER_PATH/.
    fi
    echo "Installing vim config..."
    ln -s $INSTALL_PATH/vim/.vimrc $USER_PATH/./.vimrc
fi

# konsole profile

if ask "Install konsole profile config?" Y; then
    if [ -d "$USER_PATH/.local/share/konsole" ]; then
        if [ -f "$USER_PATH/.local/share/konsole/Dark.profile" ]; then
            echo "Backing up old konsole profile config..."
            mv $USER_PATH/.local/share/konsole/Dark.profile $USER_PATH/.local/share/konsole/Dark.profile.bak
        fi
        if [ -f "$USER_PATH/.local/share/konsole/Dark.colorscheme" ]; then
            echo "Backing up old Dark.colorscheme..."
            mv $USER_PATH/.local/share/konsole/Dark.colorscheme $USER_PATH/.local/share/konsole/Dark.colorscheme.bak
        fi
    else
        mkdir $USER_PATH/.local/share/konsole
    fi
    echo "Installing konsole profile config..."
    ln -s $INSTALL_PATH/konsole/Dark.profile $USER_PATH/.local/share/konsole/Dark.profile
    ln -s $INSTALL_PATH/konsole/Dark.colorscheme $USER_PATH/.local/share/konsole/Dark.colorscheme
fi

# kitty config directory
if ask "Install kitty config directory?" Y; then
    if [ -d "$USER_PATH/.config/kitty" ]; then
        echo "Backing up old kitty config directory..."
        mv $USER_PATH/.config/kitty $USER_PATH/.config/kitty_bak
    fi
    ln -s $INSTALL_PATH/kitty $USER_PATH/.config/kitty
fi

