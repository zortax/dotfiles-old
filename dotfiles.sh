#!/bin/bash

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

install() {
    unset install
    source ./metadata/metadata.sh
 
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
    exit 0
}

remove() {
    echo "Remove"
}

add_config() {
    unset name description path

    name=`dialog --stdout --inputbox "What is the name of the config?" 10 55`
    dialog --clear
    
    if [ -z "$name" ]; then
        clear
        echo "No name provided. Exiting."
        exit 2
    fi

    description=`dialog --stdout --inputbox "Enter a short description" 10 55`
    dialog --clear
    
    if [ -z "$description" ]; then
        clear
        echo "No description provided. Exiting."
        exit 2
    fi

    path=`dialog --stdout --inputbox "Enter original config location (relative to $HOME)" 10 55`
    dialog --clear

    if [ -z "$path" ]; then
        clear
        echo "No path provided. Exiting."
        exit 2
    fi

    clear
    echo $name >> ./metadata/configs
    echo $name"_description=\""$description"\"" >> ./metadata/metadata.sh
    echo $name"_path=\""$path"\"" >> ./metadata/metadata.sh
    echo "" >> ./metadata/metadata.sh

    mkdir -p $path
    rm -r $path
    echo "Copying config..."
    cp -r $HOME/$path $path
    exit 0
}

usage() {
    echo "Usage: $0 [ -i | -r | -a ]"
    exit 2
}

unset ACTION
while getopts 'ira?h' c; do
    case $c in
        i) ACTION=install ;;
        r) ACTION=remove ;;
        a) ACTION=add_config ;;
        h|?) ACTION=usage ;;
    esac
done

[ -z "$ACTION" ] && usage

eval "$ACTION"

