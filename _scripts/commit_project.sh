function push_project(){
    git add .
    git commit -m "$1"
    git push
}

push_project "$1"