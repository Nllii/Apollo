#!/bin/bash
set -e
END='\033[0m' 
Yellow="\033[0;93m[x]" 
workflow_path=$(pwd)
if [ $1 == "-permissions" ]; then 
    echo -e "$Yellow adding permission using sudo chmod -R a+rwx "$workflow_path"$END"
    sudo chmod -R a+rwx $workflow_path
    
fi 
