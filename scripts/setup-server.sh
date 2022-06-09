#!/bin/bash
END='\033[0m' 
Yellow="\033[0;93m[x]" 

set -e
#remove sudo apt-get purge --remove mosquitto*

function github_cli(){
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt install gh
  gh auth login
  
}


function install_cockpit(){
    echo -e "${Yellow}Installing cockpit.${END}">&2
    sudo apt install --fix-missing  cockpit -y 
    sudo systemctl start cockpit
    sudo ufw allow 9090/tcp
    sudo apt install  --fix-missing cockpit-machines -y

}

function install_neofetch(){
    echo -e "${Yellow}Installing neofetch.${END}">&2

    sudo apt install neofetch -y
}

function install_golang(){
    echo -e "${Yellow}Installing golang.${END}">&2

    sudo apt install golang -y
}


function install_docker(){
    echo -e "${Yellow} Installing docker${END}"
    sudo apt autoremove -y
    sudo apt-get install \
    apt-transport-https -y \
    ca-certificates -y \
    curl -y \
    gnupg -y \
    lsb-release -y 
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg  --y --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
    "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get install docker-ce  docker-ce-cli containerd.io -y
    sudo usermod -aG docker $USER
    echo -e "${Yellow} Installing docker compose${END}"
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

}

function install_mosquitto(){
    echo -e "${Yellow}adding mosquitto to docker.${END}">&2
    # docker pull arm64v8/eclipse-mosquitto:latest

    # sudo docker-compose -f $(pwd)/mosquitto-compose.yml up -d

    # https://www.homeautomationguy.io/docker-tips/configuring-the-mosquitto-mqtt-docker-container-for-use-with-home-assistant/
    # sudo apt install mosquitto -y




}
function install_portainer(){
    echo -e "${Yellow} Installing Portainer${END}"
    sudo usermod -aG docker $USER
    cd ~/
    sudo docker pull portainer/portainer-ce:latest
    sudo docker volume create portainer_data
    sudo docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce


}

function libreddit(){
    
    docker build -f Dockerfile.arm . -t arm64v8/libreddit:latest
    # sudo docker pull spikecodes/libreddit:arm
    sudo docker run  -d --name libreddit -p 80:8081 spikecodes/libreddit:arm
   docker update --restart always $(docker ps -q)
}



if [ $1 == "-everything" ]; then 
    echo -e "${Yellow}- installing everything -${END}"
    # sudo apt update && sudo apt upgrade -y
    # sudo apt autoremove -y
    # sudo apt install default-jdk -y
    # github_cli
    # install_cockpit
    # install_neofetch
    # install_golang
    # install_docker
    # install_portainer
    # install_mosquitto
    # libreddit
    
    
fi

