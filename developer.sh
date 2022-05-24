#!/bin/sh
set -e

# Check that dokku is installed on the server
ensure-dokku() {
  if ! command -v dokku &> /dev/null
  then
      echo "dokku is not installed, please follow our getting started guide first"
      echo "https://www.ledokku.com/docs/getting-started"
      exit
  fi
}

function miniconda(){
    cd ~/
    curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh"
    bash Mambaforge-$(uname)-$(uname -m).sh
    conda create -n dev python=3.9

    
}


function install_dokku(){
  wget https://raw.githubusercontent.com/dokku/dokku/v0.27.4/bootstrap.sh
  sudo DOKKU_TAG=v0.27.4 bash bootstrap.sh
#   exit 1

}

function install_Portainer(){
    echo "installing Portainer"
    docker pull portainer/portainer-ce:latest && docker volume create portainer_data && sudo docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

    # sudo docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

}


# miniconda

# install_Portainer





# if ! [ -x "$(command -v dokku)" ]; then
#   echo 'Error: dokku is not installed.' >&2
#   echo 'installing dokku which will also install docker' >&2
#   echo 'YOU NEED TO BE ROOT' >&2
# #   install_dokku
# fi



