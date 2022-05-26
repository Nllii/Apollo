#!/bin/bash
# set -e 

RED='\033[0;31m'
White="\[\033[0;37m\]"
END='\033[0m' 
IYellow="\033[0;93m[x]"
IYellow_task="\033[0;93m ====> "     


# ask if user wants to create a new name or use the current one

echo -e "\n${IYellow}Getting project name ${END}"
project_name=$(git config --get remote.origin.url | sed 's/.*\/\(.*\)\.git/\1/')

# pass in the name of the image
build_image(){
    # search for the image in the dockerfile
    # search for Dockerfile in the current directory
    if ! [ -f "Dockerfile" ]; then
        echo -e "${IYellow_task} No Dockerfile found. Please create one.${END}"
        exit 1
    fi
    sudo docker build --tag workflow .
    echo -e "${IYellow_task} Image built: ${image_name}${END}"
    # ask if we to run the image
    echo -e "${IYellow_task} Would you like to run the image?${END}"
    read -p "y: " run_image
    if [ "$run_image" = "y" ]; then
        echo -e "${IYellow_task} Running image: ${image_name}${END}"
        sudo docker run -d $image_name
        else
        echo -e "${IYellow_task} Not running image: ${image_name}${END}"
        exit 1
    fi
    

    # if so, then push the image

}
run_docker(){
    echo -e "${IYellow_task} ***** Re-runing docker image*******${END}"
    echo -e "${IYellow_task} STOPING: ${project_name}${END}"
    contain_id=$(sudo docker ps | grep $project_name | awk '{print $1}')
    sudo docker stop "$contain_id"
    echo -e "${IYellow_task} BUILDING: ${project_name}${END}"
    sudo docker build --tag $project_name .
    sudo docker run -d $project_name
}

    # sudo docker run -d $image_name
    # docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

$1 $2 $3 $4 $5 $6 $7 $8 $9

# build_image 

