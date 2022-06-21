#!/bin/bash
END='\033[0m' 
Yellow="\033[0;93m[x]" 
set -e
# if [ -x "$(command -v docpht)" ]; then
#     echo -e "${Yellow}docpht already installed.${END}">&2
# else
#     echo -e "${Yellow}Installing docpht.${END}">&2
#     pip install docpht
# fi
if [ $1 == "-install-persistence_data" ]; then 
    echo -e "${Yellow}adding  persistence_data ${END}">&2
    docker run -d --name docpht_workflow -p 8070:80 -p 443:443 -t  \
    -v /var/www/app/src/config:/var/www/app/src/config \
    -v /var/www/app/data:/var/www/app/data \
    -v /var/www/app/pages:/var/www/app/pages \
    -v /etc/nginx/ssl:/etc/nginx/ssl \
    docpht_workflow:latest
else 
    # if this else statement prints, thats voodoo magic.
    echo -e "${Yellow}Starting docpht.${END}">&2
    # docker start docpht

fi 


if [ $1 == "-install-docpht" ]; then 
    echo -e "${Yellow}Installing docpht.${END}">&2
    cd ~/workflow/services/docpht_docker/
    if [ -d "docpht" ]; then
        echo -e "${Yellow}docpht folder exists.${END}">&2
        if [ -f "./docpht/Dockerfile" ]; then
            echo -e "${Yellow}found Dockerfile.${END}">&2
        else
            echo -e "${Yellow}no Dockerfile found.${END}">&2
            sudo rm -rf ./services/docpht_docker/docpht
            cd ~/workflow/services/docpht_docker/
            git clone https://github.com/docpht/docpht.git
        fi
    else
        echo -e "${Yellow}docpht folder does not exist.${END}">&2
        git clone https://github.com/docpht/docpht.git
    fi
fi





if [ $1 == "-cockpit" ]; then 
    echo -e "${Yellow}Installing cockpit.${END}">&2
    sudo apt install --fix-missing  cockpit -y 
    sudo systemctl start cockpit
    sudo ufw allow 9090/tcp
    sudo apt install  --fix-missing cockpit-machines -y
# else
    # echo -e "${Yellow}Installing git.${END}">&2 
fi


if [ $1 == "-neofetch" ]; then 
    echo -e "${Yellow}Installing neofetch.${END}">&2
    sudo apt install neofetch -y

fi


if [ $1 == "-install-github-cli" ]; then 
    echo -e "${Yellow}Installing github-cli.${END}">&2
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt install gh
    gh auth login

fi


if [ $1 == "-install-golang" ]; then 
    echo -e "${Yellow}Installing golang.${END}">&2
    sudo apt install golang -y
fi



if [ $1 == "-install-docker" ]; then 
    echo -e "${Yellow}Installing docker.${END}">&2
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
    echo -e "${Yellow} Installing docker compose ${END}"
    # todo: if v2.5.0 isn't available, in the next 5-10 years... let the user know
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

if [ $1 == "-install-portainer" ]; then 
    echo -e "${Yellow} Installing Portainer${END}"
    sudo usermod -aG docker $USER
    cd ~/
    sudo docker pull portainer/portainer-ce:latest
    sudo docker volume create portainer_data
    sudo docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
    echo "Portainer is running on http://localhost:9000 or http://ip:9000"
fi


if [ $1 == "-install-libreddit" ]; then 
    echo -e "${Yellow} Installing libreddit${END}"
    sudo docker pull spikecodes/libreddit:arm
    sudo docker run  -d --name libreddit -p 80:8022 spikecodes/libreddit:arm
fi


if [ $1 == "-install-java" ]; then 
    echo -e "${Yellow} Installing java jdk ${END}"
    sudo apt update && sudo apt upgrade -y
    sudo apt autoremove -y
    sudo apt install default-jdk -y
fi 





if [ $1 == "-everything" ]; then 
    echo -e "${Yellow}- installing everything -${END}"
    # sudo apt update && sudo apt upgrade -y
    # sudo apt autoremove -y
    # github_cli
    # install_docker
    # sudo apt install default-jdk -y
    # install_cockpit
    # install_neofetch
    # install_golang
    # install_portainer
    # libreddit
    
    
fi

