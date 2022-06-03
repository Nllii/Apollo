#!/bin/bash
# set -e 

RED='\033[0;31m'
White="\[\033[0;37m\]"
END='\033[0m' 
Yellow="\033[0;93m[x]"
workflow_path=$(pwd)


# run_docker(){
#     echo -e "${Yellow_task} ***** Re-runing docker image*******${END}"
#     echo -e "${Yellow_task} STOPING: ${project_name}${END}"
#     contain_id=$(sudo docker ps | grep $project_name | awk '{print $1}')
#     sudo docker stop "$contain_id"
#     echo -e "${Yellow_task} BUILDING: ${project_name}${END}"
#     sudo docker build --tag $project_name .
#     sudo docker run -d $project_name
# }



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
    echo -e "${Yellow_task}docker compose ${project_name}${END}"
    sudo docker-compose up -d

fi 



    # sudo docker run -d $image_name
    # docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

# $1 $2 $3 $4 $5 $6 $7 $8 $9

# build_image 

