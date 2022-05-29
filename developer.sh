set -e 
RED='\033[0;31m'
White="\[\033[0;37m\]"
END='\033[0m' 
IYellow="\033[0;93m[x]" 
project_name=$(basename $(pwd))
script_folder=$(dirname $(readlink -f $0))

function choose_from_menu() {
    local prompt="$1" outvar="$2"
    shift
    shift
    local options=("$@") cur=0 count=${#options[@]} index=0
    local esc=$(echo -en "\e") # cache ESC as test doesn't allow esc codes
    printf "$prompt\n"
    while true
    do
        # list all options (option list is zero-based)
        index=0 
        for o in "${options[@]}"
        do
            if [ "$index" == "$cur" ]
            then echo -e "[x]\e[7m$o\e[0m" # mark & highlight the current option
            else echo " $o  "
            fi
            index=$(( $index + 1 ))
        done
        read -s -n3 key # wait for user to key in arrows or ENTER
        if [[ $key == $esc[A ]] # up arrow
        then cur=$(( $cur - 1 ))
            [ "$cur" -lt 0 ] && cur=0
        elif [[ $key == $esc[B ]] # down arrow
        then cur=$(( $cur + 1 ))
            [ "$cur" -ge $count ] && cur=$(( $count - 1 ))
        elif [[ $key == "" ]] # nothing, i.e the read delimiter - ENTER
        then break
        fi
        echo -en "\e[${count}A" # go up to the beginning to re-render
    done
    # export the selection to the requested output variable
    printf -v $outvar "${options[$cur]}"
}








selections=(
"1. git commit"

)



choose_from_menu " - Development Task  :" selected_choice "${selections[@]}"
if [ "$selected_choice" == "1. git commit" ]; then
    echo -e "${White} - git commit -${END}"
    read -p "Enter commit message: " commit_message
    cd ./_scripts/
    ls 
    bash commit_project.sh  "$commit_message"

fi

#     # bash git_commit.sh

#     # bash /workflow/_scripts/commit_project.sh
#     # git init
# fi

# # echo "Selected choice: $selected_choice"