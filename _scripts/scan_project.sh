#!/bin/bash
RED='\033[0;31m'
END='\033[0m' # No Color

#open file in read mode and read the first line
cd ..
read -r account_ < credentials.txt
token=$account_ 
token_=${token#*=}
TOKEN=$token_




function github_init()
{

repo_name=$(basename $(pwd))
read -r -d '' PAYLOAD <<EOP
{
"name": "$repo_name",
"private": true
}
EOP

curl curl -H "Authorization: token $TOKEN" --data "$PAYLOAD" \
    https://api.github.com/user/repos  --silent -o /dev/null --write-out "%{http_code}"

}



function create_repo() {
    if [ -z "$repo_name" ]; then
        repo_name=$(basename $(pwd))

        
    fi
    username=$(git config --global user.name)
    remote_url="https://github.com/$username/$repo_name.git"

    if [ -d ".git" ]; then
        echo "Already a git repo"
    else
        echo -e "${RED}creating repository : ${repo_name} ${END}"
        github_init
        echo "guessing remote url: "$remote_url
        git init
        git add .gitignore
        git remote add origin $remote_url
        git add .
        git commit -m "Initial commit"
        git push -u origin master
    fi

    echo -e "${RED}repository created: ${repo_name} ${END}"
}


function re_init_repo() {
        rm -rf .git
        if [[ -f README.md ]]; then
                echo -e "${RED}FOUND README.md remove it manually${NC}"
        else
            touch README.md
            echo -e "${RED}Successfully created a  new README.md${NC}"
            create_repo

        fi


}




if [ -d .git ]; then
    printf "${RED}Found a  .git directory in your project already [$(pwd)]${NC}\n"
    printf "Do you want to create a new repository? [y/n] "
    read -r answer
    if [ "$answer" == "y" ]; then
        re_init_repo
    fi
else
    echo "No .git directory found"
    create_repo
fi


