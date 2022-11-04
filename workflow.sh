# !/bin/bash
# https://docs.brew.sh/Installation
# https://sharats.me/posts/shell-script-best-practices/
set -u
set -o errexit
set -o nounset
set -o pipefail
project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname)"

if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi


if [[ -t 1 ]]
then
  tty_escape() { printf "\033[%sm" "$1"; }
else
  tty_escape() { :; }
fi
tty_mkbold() { tty_escape "1;$1"; }
tty_underline="$(tty_escape "4;39")"
tty_yellow="$(tty_mkbold 33)"
tty_blue="$(tty_mkbold 34)"
tty_red="$(tty_mkbold 31)"
tty_bold="$(tty_mkbold 39)"
tty_reset="$(tty_escape 0)"

shell_join() {
  local arg
  printf "%s" "$1"
  shift
  for arg in "$@"
  do
    printf " "
    printf "%s" "${arg// /\ }"
  done
}
execute() {
  if ! "$@"
  then
    abort "$(printf "Failed during: %s" "$(shell_join "$@")")"
  fi
}

chomp() {
  printf "%s" "${1/"$'\n'"/}"
}


warn() {
  printf "${tty_yellow}Warning${tty_reset}: %s\n" "$(chomp "$1")"
}
abort() {
  printf "${tty_red}fail${tty_reset}: %s\n" "$(chomp "$1")"
  exit 0
}
abort_println() {
  printf "${tty_red}performing${tty_reset}: %s\n" "$(chomp "$1")"
  # exit 0
}
perform_task() {
  printf "${tty_blue}==>${tty_bold} %s${tty_reset}\n" "$(shell_join "$@")"
}






install_all(){
    warn "install_all"
    
}




server_config(){
    if [[ "${1-}" =~ ^-*ser(all)?$ ]]; then 
        perform_task "$1 is the server config"
    fi

    if [[ "${1-}" =~ ^-*ser(bye)?$ ]]; then 
        perform_task "$1 is the server config bye"
    fi
}

if [[ $1 == "-server" ]]; then
    if [[ "${OS}" == "aDarwin" ]]
    then
        echo "server can only be config on Linux system not ${OS}"
        exit 0
        else
        echo "server config"
        # exit 0 
        # echo "$1 $2"
        # server_config "$2"
        # exit 0 
        # server_config "$@"
    fi
fi