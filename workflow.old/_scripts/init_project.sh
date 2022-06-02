#!/bin/bash
# set -e
RED='\033[0;31m'
END='\033[0m' # No Color
ORANGE='\033[0;33m'


function gh_cli(){
    cd ..
    read -p "The project name : " project_name
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

function re_init_repo() {
        if [[ -f README.md ]]; then
                echo -e "${RED}FOUND README.md remove it manually${NC}"
        else
            touch README.md
            echo -e "${RED}Successfully created a  new README.md${NC}"
            rm -rf .git
            gh_cli

        fi


}


if [ -d .git ]; then
    cd ..
    printf "${RED}Found a  .git directory in your project already [$(pwd)]${NC}\n"
    printf "Do you want to create a new repository? [y/n] "
    read -r answer
    if [ "$answer" == "y" ]; then
        echo -e "${RED}repository created: ${repo_name} ${END}"

        re_init_repo
        
    fi
else
    echo "No .git directory found"
    # check if gh CLI is installed
    if [ -x "$(command -v gh)" ]; then
        printf "${RED}Using gh CLI${NC}\n"
        gh_cli
    else
        exit 1
    fi
fi
