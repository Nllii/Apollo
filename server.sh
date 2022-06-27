#!/bin/bash
RED=$(tput -Txterm setaf 1)
GREEN=$(tput -Txterm setaf 2)
YELLOW=$(tput -Txterm setaf 3)
BLUE=$(tput -Txterm setaf 4)
MAGENTA=$(tput -Txterm setaf 5)
CYAN=$(tput -Txterm setaf 6)
WHITE=$(tput -Txterm setaf 7)
RESET=$(tput -Txterm sgr0)

echo -e $WHITE
SERVER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVICES=($(ls $SERVER_DIR/services))
echo "workflow __dir: $SERVER_DIR"
echo -e $RESET

# _cleanup() {
#   trap - SIGINT SIGTERM ERR EXIT
#   echo
# }


trap catch_little_errors ERR

function catch_little_errors() {
  echo -e $CYAN
  echo  -e "workflow probably exit  because no make command or something else. \ndo  # sudo apt-get update && sudo apt install build-essential -y \nand re-run the script again"
  echo -e "looks like ${important[$i]} has an error or exit"
  sudo apt-get update && sudo apt-get install build-essential -y
  echo -e $RESET
  echo -e $RED
  echo -e "# TODO: ask for system  reboot. For now skipping"
  echo -e $RESET
  exit
  # make -s -C "$SERVER_DIR/services/${important[$i]}" error
  # sudo apt-get update && sudo apt install build-essential -y
  # sudo reboot

}



declare -a important=(
"docker" 
"portainer"
"github_cli"
"cockpit"

)
important_=${#important[@]}
echo "installing the important stuff first"
# use for loop to read all values and indexes
for (( i=0; i<${important_}; i++ ));
do
  # check to see if its important with the .important file 
  if [[ -f "$SERVER_DIR/services/${important[$i]}/.is_important" ]]; then
    if [[ -f "$SERVER_DIR/services/${important[$i]}/.enable" ]]; then
      echo -e $MAGENTA
      echo "${important[$i]} already enabled."  
      echo -e $REST
    else
      echo -e $YELLOW
      echo "installing ${important[$i]}"
      make -s -C "$SERVER_DIR/services/${important[$i]}" is_script
      echo "adding .enabled to directory"
      make -s -C "$SERVER_DIR/services/${important[$i]}" 
      echo -e $REST
    fi
  fi
done



for service in "${SERVICES[@]}"

do
  #  make -s -C "$SERVER_DIR/services/$service" 
    if [[ -f "$SERVER_DIR/services/$service/.is_unimportant" ]]; then
      if [[ -f "$SERVER_DIR/services/$service/.enable" ]]; then
        echo -e $MAGENTA
        echo "$service already enabled."  
        echo -e $REST
      else
        echo -e $YELLOW
        echo "installing $service"
        make -s -C "$SERVER_DIR/services/$service" is_script
        echo "adding .enabled to directory"
        make -s -C "$SERVER_DIR/services/$service" 
        echo -e $REST
      fi
    fi
done




#TODO: clean up the mess before git push skipping for now. Since no one is using this script. 
# for service in "${SERVICES[@]}"
# do
#   #  make -s -C "$SERVER_DIR/services/$service" 
#     if [[ -f "$SERVER_DIR/services/$service/.is_unimportant" ]]; then
#       if [[ -f "$SERVER_DIR/services/$service/.enable" ]]; then
#         echo -e $MAGENTA
#         echo "$service enabled. is getting removed"  
#         make -s -C "$SERVER_DIR/services/$service" 
#         echo -e $REST

#       fi
#     fi
# done