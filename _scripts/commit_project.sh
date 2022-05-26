RED='\033[0;31m'
White="\[\033[0;37m\]"
END='\033[0m' 
IYellow="\033[0;93m[x]" 

function push_project(){
    echo -e "${IYellow}Pushing project commit: \n$1${END}"
    git add .
    git commit -m "$1"
    git push
    echo -e "\n${IYellow}Commit message: $1${END}"

}

push_project "$1"