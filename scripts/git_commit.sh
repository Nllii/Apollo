#!/bin/bash
set -e
END='\033[0m' 
Yellow="\033[0;93m[x]" 

echo -e "${Yellow}Pushing project commit: \n$1${END}"
git add .
git commit -m "$1"
git push
echo -e "\n${Yellow}Commit message: $1${END}"



