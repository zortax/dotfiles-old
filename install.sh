#!/bin/bash

source ./metadata/metadata.sh

get_description() {
    var=$1"_description"
    eval "ret=\$$var"
    echo "$ret"
}
get_path() {
    var=$1"_path"
    eval "ret=\$$var"
    echo "$ret"
}

dialog_cmd="dialog --stdout --checklist \"Select configs to install:\" 0 0 0"

while read cfg; do
    dialog_cmd+=" "$cfg" \""
    dialog_cmd+=`get_description $cfg`
    dialog_cmd+="\" off"
done < ./metadata/configs
install=`eval "$dialog_cmd"`
dialog --clear
clear
for cfg in $install; do
    echo "Installing $cfg config..."
    location=`get_path $cfg`
    if [ -f $HOME/$location ] || [ -d $HOME/$location ]; then
        if [ -L $HOME/$location ]; then
            rm $HOME/$location
        else
            echo "Backing up already present $cfg config..."
            mv $HOME/$location $HOME/$location.bak
        fi
    fi
    ln -s $PWD/$location $HOME/$location
done

echo "All done!"

