#!/bin/bash

NAME=$1
FILE=$2
REPO_PATH=$3
INSTALL_PATH=$4

echo "# $NAME" >> install.sh
echo "" >> install.sh
echo "if ask \"Install $NAME config?\" Y; then" >> install.sh
echo "    if [ -d \"\$USER_PATH/$INSTALL_PATH\" ]; then" >> install.sh
echo "        if [ -f \"\$USER_PATH/$INSTALL_PATH/$FILE\" ]; then" >> install.sh
echo "            echo \"Backing up old $1 config...\"" >> install.sh
echo "            mv \$USER_PATH/$INSTALL_PATH/$FILE \$USER_PATH/$INSTALL_PATH/$FILE.bak" >> install.sh
echo "        fi" >> install.sh
echo "    else" >> install.sh
echo "        mkdir \$USER_PATH/$INSTALL_PATH" >> install.sh
echo "    fi" >> install.sh
echo "    echo \"Installing $NAME config...\"" >> install.sh
echo "    ln -s \$INSTALL_PATH/$REPO_PATH/$FILE \$USER_PATH/$INSTALL_PATH/$FILE" >> install.sh
echo "fi" >> install.sh
echo "" >> install.sh

