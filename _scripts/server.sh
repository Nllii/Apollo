#!/bin/bash
# give a list of directory and file to backup
# https://omar2cloud.github.io/rasp/rpidock/

RED='\033[0;31m'
White="\[\033[0;37m\]"
END='\033[0m' 
IYellow="\033[0;93m[x]" 

function install_docker(){
    echo -e "${IYellow}Installing docker...${END}"
    sudo apt autoremove -y
    sudo apt update && sudo apt upgrade -y
    sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    curl --version
    sudo apt-get install curl -y

    echo \
    "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io
    sudo usermod -aG docker $USER
    sudo systemctl enable docker
    sudo systemctl start docker
    echo -e "${IYellow}Docker installed!${END}"

}


function install dokku(){
    # Add Dokku apt repository
    wget -nv -O - https://packagecloud.io/gpg.key | sudo apt-key add -
    export SOURCE="https://packagecloud.io/dokku/dokku/ubuntu/"
    echo "deb $SOURCE trusty main" | sudo tee /etc/apt/sources.list.d/dokku.list
    sudo apt-get update -qq

    # wget https://raw.githubusercontent.com/dokku/dokku/v0.27.4/bootstrap.sh;
    # sudo DOKKU_TAG=v0.27.4 bash bootstrap.sh
}





function server_setup(){
    echo -e "${IYellow} ******* Developer setup setup *******  ${END}"
    echo  -e "${IYellow}===> Installing docker...${END}"
    install_docker
    echo -e "${IYellow}===> Installing Portainer.${END}"
    cd ~/
    docker pull portainer/portainer-ce:latest
    docker volume create portainer_data
    sudo docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
    echo -e "${IYellow}===> Installing Miniforge.${END}"
    curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
    bash Mambaforge-$(uname)-$(uname -m).sh -y
    echo -e "${IYellow}===> Installing Miniconda.${END}"
    conda create -n test-environment python=3.7
    source activate test-environment



}