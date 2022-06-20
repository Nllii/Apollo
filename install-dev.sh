#!/bin/bash
end='\033[0m' 
yellow="\033[0;93m[x]" 
set -e

echo    # (optional) move to a new line
if [ -x "$(command -v dev)" ]; then
    echo -e "${yellow}dev is already in your path? \nremove it in in ~/.bashrc \n${end}"
    echo -e "${yellow}and source ~/.bashrc  and  run 'exec su -l $USER '\n${end}"
    else 
    read -p "Do you want workflow in your path? (y/n)" -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo "export PATH=\$PATH:$(pwd)" >> ~/.bashrc
        chmod +x dev
        echo    # (optional) move to a new line
        echo "reloading bashrc ..."
        source ~/.bashrc
        exec su -l $USER
    fi

fi





