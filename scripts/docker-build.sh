#!/bin/bash
# set -e 

RED='\033[0;31m'
White="\[\033[0;37m\]"
END='\033[0m' 
Yellow="\033[0;93m[x]"
workflow_path=$(pwd)


if [ $1 == "-build" ]; then 
    project_name=$(git config --get remote.origin.url | sed 's/.*\/\(.*\)\.git/\1/')
    if ! [ -f $workflow_path/"Dockerfile" ]; then
        echo -e "${RED}No Dockerfile found.${END}"
        exit 1
    fi
    echo -e "${Yellow_task}Building docker image ${project_name}${END}"
    read -p "Dockerfile name or leave blank: " dockerfile_name
    if [ -z "$dockerfile_name" ]; then
        if [ "$project_name" != "$(echo $project_name | tr '[:upper:]' '[:lower:]')" ]; then
            echo -e "${RED}Project name must be lowercase.${END}"
            project_name=$(echo $project_name | tr '[:upper:]' '[:lower:]')
            echo -e "${Yellow_task}Project name changed to ${project_name}${END}"
            sudo docker build --tag $project_name .
            sudo docker run -d $project_name
        else
            echo -e "${Yellow_task}Building project: $project_name${END}"
            sudo docker build --tag $project_name .
            sudo docker run -d $project_name
        fi
    else
        echo -e "${Yellow_task}Building project: $project_name with Dockrfile :$dockerfile_name${END}"
        sudo docker build --tag $project_name:$dockerfile_name .
        sudo docker run -d $project_name:$dockerfile_name
    fi
 fi 
    


if [ $1 == "-compose-build" ]; then 
    project_name=$(git config --get remote.origin.url | sed 's/.*\/\(.*\)\.git/\1/')
    if ! [ -f $workflow_path/"docker-compose.yml" ]; then
        echo -e "${RED}No docker-compose.yml found.${END}"
        exit 1
    fi
    echo -e "${RED}using --no-cache build  ${project_name}${END}"
    docker-compose build --no-cache && sudo docker-compose up -d 

fi 


