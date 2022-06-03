#!/bin/bash
set -e
RED='\033[0;31m'
END='\033[0m' # No Color
ORANGE='\033[0;33m'





function github_cli(){
    cd ..
    read -p "The project name : " $1
    echo -e "${ORANGE}creating private repository : ${project_name} ${END}"
    gh repo create "$project_name" --private
    username=$(git config --global user.name)
    remote_url="https://github.com/$username/$project_name.git"
    read -p "Do you want to initialize a git repo? (y/n) : " git_init
    if [ "$git_init" == "y" ]; then
        echo -e "${ORANGE}initializing git repo : ${project_name} ${END}"
        if [ -d ".git" ]; then
            echo "Already a git repo"
        else
            git init
            git add .gitignore
            git remote add origin $remote_url
            git add .
            git commit -m "Initial commit"
            git push -u origin master
        fi
    fi
    exit 0
}

if [ -x "$(command -v gh)" ]; then
    printf "${ORANGE}Using github CLI${END}\n"
    # gh_cli
else
    printf "${ORANGE}github CLI not found${END}\n"

    # exit 1
fi
$1