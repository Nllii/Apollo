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
# }


trap catch_little_errors exit 

function catch_little_errors() {
  echo -e $CYAN
  echo  -e "workflow probably exit  because no make command or something else. \ndo  # sudo apt-get update && sudo apt install build-essential -y \n and re-run the script again"
  # sudo apt-get update && sudo apt install build-essential -y
  echo -e $RESET
  echo -e $RED
  echo -e "rebooting system"
  echo -e $RESET
  # sudo reboot

}



for service in "${SERVICES[@]}"
do
  echo -e $YELLOW
  echo "installing service: $service"
  echo -e $RESET
   if [[ -f "$SERVER_DIR/services/$service/..is_important" ]]; then
    echo -e $YELLOW
    make -s -C "$SERVER_DIR/services/$service" is_script
    echo -e $RESET
  fi
  if [[ -f "$SERVER_DIR/services/$service/.is_important" ]]; then
    echo -e $YELLOW
    make -s -C "$SERVER_DIR/services/$service" is_script
    echo -e $RESET
  fi

  if [[ -f "$SERVER_DIR/services/$service/.is_unimportant" ]]; then
    echo -e $YELLOW
    make -s -C "$SERVER_DIR/services/$service" is_script
    echo -e $RESET
  fi

done

