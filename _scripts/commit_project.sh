RED='\033[0;31m'
White="\[\033[0;37m\]"
END='\033[0m' 
IYellow="\033[0;93m[x]" 

function push_project(){
    echo -e "${IYellow}Pushing project$1${END}"
    git add .
    git commit -m "$1"
    git push
    echo -e "${IYellow}\nCommit message: $1${END}"

}

push_project "$1"