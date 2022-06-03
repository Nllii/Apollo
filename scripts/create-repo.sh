#!/bin/bash
set -e
RED='\033[0;31m'
END='\033[0m' # No Color
ORANGE='\033[0;33m'

# function call_github(){
#     echo -e "${ORANGE}Creating repository on GitHub...${END}"


# }



# function repository_creator(){
#     echo -p "do you want to create a repository on GitHub first? (y/n)"
#     read answer
#     if [ "$answer" == "y" ]; then
#         call_github
#     else
#         echo -e "${RED}Exiting...${END}"
#         exit
#     fi
# }








# echo -e "${ORANGE}Creating folder for repo...${END}"
# mkdir -p $1
# cd $1



# github_cli(){
#     echo -e "${ORANGE}Creating repo ${1}${END}"
#     read -p "create repo in current directory [y/n] :" 
#     if [ "$REPLY" == "y" ]; then
#         echo -e "${ORANGE}Creating repo in current directory...${END}"
#         echo -e "${ORANGE}creating private repository : ${$1} ${END}"
#         gh repo create "$1" --private
#         username=$(git config --global user.name)
#         remote_url="https://github.com/$username/$1.git"
#         read -p "Do you want to initialize a git repo? (y/n) : " git_init
#         if [ "$git_init" == "y" ]; then
#             echo -e "${ORANGE}initializing git repo : ${project_name} ${END}"
#             if [ -d ".git" ]; then
#                 echo "Already a git repo"
#             else
#                 git init
#                 git add .gitignore
#                 git remote add origin $remote_url
#                 git add .
#                 git commit -m "Initial commit"
#                 git push -u origin master
#             fi
#             exit 0
#         fi
#     else
#         echo -e "${RED}Exiting...${END}"
#         exit 0
#     fi
# }

    # git init

    # if [ -z "$create_repodir" ]; then
    #     create_repodir="$PWD"
    #     else 
    #     create_repodir="$PWD/$1"
    # fi
    # cd $create_repodir

    # echo -e "${ORANGE}creating private repository : ${project_name} ${END}"
    # gh repo create "$project_name" --private
    # username=$(git config --global user.name)
    # remote_url="https://github.com/$username/$project_name.git"
    # read -p "Do you want to initialize a git repo? (y/n) : " git_init
    # if [ "$git_init" == "y" ]; then
    #     echo -e "${ORANGE}initializing git repo : ${project_name} ${END}"
    #     if [ -d ".git" ]; then
    #         echo "Already a git repo"
    #     else
    #         git init
    #         git add .gitignore
    #         git remote add origin $remote_url
    #         git add .
    #         git commit -m "Initial commit"
    #         git push -u origin master
    #     fi
    # fi
    # exit 0







if [ -x "$(command -v gh)" ]; then
printf "${ORANGE}Using github CLI${END}\n"
while true; do
    read -p "Do you want to create a repository on GitHub first ? (y/n) : " answer
    # read -p "have you already started a project ? (y/n) : " project_start
    if [ "$answer" == "y" ]; then
        gh repo create 
        break
        # read -p "Enter the name of the project : " project_name
        # github_cli "$project_name"
    else
        echo -e "${RED}Exiting...${END}"
        exit 0
    fi
done 
else
    echo -e "${RED}github CLI not installed${END}"
    echo -e "${RED}Exiting...${END}"
    exit 0
fi