#!/bin/bash

name=`dialog --stdout --inputbox "What is the name of the config?" 10 55`
dialog --clear

description=`dialog --stdout --inputbox "Enter a short description" 10 55`
dialog --clear

path=`dialog --stdout --inputbox "Enter original config location (relative to $HOME)" 10 55`
dialog --clear
clear
echo $name >> ./metadata/configs
echo $name"_description=\""$description"\"" >> ./metadata/metadata.sh
echo $name"_path=\""$path"\"" >> ./metadata/metadata.sh
echo "" >> ./metadata/metadata.sh

mkdir -p $path
rm -r $path
echo "Copying config..."
cp -r $HOME/$path $path

