#!/bin/bash


set -e

function github_cli(){
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt install gh
  gh auth login
  
}


function install_cockpit(){
    echo -e "${IYellow}Installing cockpit.${END}">&2
    sudo apt install cockpit -y
    sudo systemctl start cockpit
    sudo ufw allow 9090/tcp
    sudo apt install cockpit-machines -y

}

function install_neofetch(){
    sudo apt install neofetch -y
}

function install_golang(){
    sudo apt install golang -y
}

function install_mosquitto(){
    
    # https://www.homeautomationguy.io/docker-tips/configuring-the-mosquitto-mqtt-docker-container-for-use-with-home-assistant/
    sudo apt install mosquitto -y



}

if [ $1 == "-i" ]; then 
    github_cli
    install_cockpit
    install_neofetch
    install_golang
    install_mosquitto
    

        # install_python
    # fi
    
fi



# workflow_path=$(pwd)
# install_everything(){
#     echo -e "${Yellow}installing Conda for python management${END}"
# }


