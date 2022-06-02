#!/bin/bash
# check if we have a valid number of parameters
# set path to the script
set -e

function setup_path(){
    read -p "Do you want workflow in your path? (y/n)" -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo "installing workflow in your path ..."
        echo "export PATH=\$PATH:$(pwd)" >> ~/.bashrc
        chmod +x dev
        echo "reloading bashrc ..."
        source ~/.bashrc
        read -p "do you want logout to init?" -n 1 -r
        echo    # (optional) move to a new line
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            echo "logging out ..."
            logout
        fi

        # echo "workflow installed in your path logout and login again to use"
        # logout

    fi

}



if [ $# -lt 1 ]; then
    # if [ $(id -u) != "0" ]; then
    #     echo "Error: You must be root to run this script"
    #     exit 1
    # fi
    echo "Error: You must specify a parameter"
    echo "Usage: sudo bash install-workflow.sh <parameter>"
    echo "Parameters:"
    echo "  -h, --help: show this help"
    echo "  -i, --install: install the workflow"
    
    # echo "  -u, --uninstall: uninstall the workflow"
    # echo "  -r, --remove: remove the workflow"
    # echo "  -l, --list: list all installed workflows"
    # echo "  -s, --status: show the status of the workflow"
    exit 1
fi

# get the parameter
# if [ $1 == "-h" ] || [ $1 == "--help" ]; then
#     if [ $(id -u) != "0" ]; then
#             echo "Error: You must be root to run this script"
#             exit 1
#     fi
#     echo "Usage: sudo bash install-workflow.sh <parameter>"
#     echo "Parameters:"
#     echo "  -h, --help: show this help"
#     echo "  -i, --install: install the workflow"
#     echo "  -u, --uninstall: uninstall the workflow"
#     echo "  -r, --remove: remove the workflow"
#     echo "  -l, --list: list all installed workflows"
#     echo "  -s, --status: show the status of the workflow"
#     exit 0
# fi

if [ $1 == "-i" ] || [ $1 == "--install" ]; then 
    if ! [ -x "$(command -v dev)" ]; then   
        echo "installing workflow ..."
        # setup_path
        # exit 1
    fi
        # bash server-setup.sh -i
    # if [ $(id -u) != "0" ]; then
    #     echo "Error: You must be root to run this script"
    #     exit 1
    #     else 
    # fi
fi 