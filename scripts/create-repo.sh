#!/bin/bash
set -e
RED='\033[0;31m'
END='\033[0m' # No Color
ORANGE='\033[0;33m'
Yellow="\[\033[0;93m\]"



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