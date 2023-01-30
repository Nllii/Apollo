#!/bin/bash
# https://docs.brew.sh/Installation
# https://sharats.me/posts/shell-script-best-practices/
set -u
set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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


# chomp() {
#   printf "%s" "${1/"$'\n'"/}"
# }

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

UNAME_MACHINE="$(/usr/bin/uname -m)"
if [[ "${UNAME_MACHINE}" != "arm64" ]] && [[ "${UNAME_MACHINE}" != "x86_64" ]]
then
    if [[ "${UNAME_MACHINE}" == "aarch64" ]]
    then
        warn "Raspberry Pi 4 is not fully supported."
    else
        abort "only supported on Intel and ARM processors!."
    fi
fi

# TODO provide a way to override path option for testing purposes
OS="$(uname)"
if [[ "${OS}" == "Linux" ]]
then
    local_executable="/usr/local"

elif [[ "${OS}" == "Darwin" ]]
then
    local_executable="/usr/local"
else
  abort "This script is only supported on macOS and Linux."
fi

link_project(){
    perform_task "creating symbolic link  and doing chmod +x dev..."
    chmod +x dev
    execute "sudo" "ln" "-sfv" "$project_dir/dev" "${local_executable}/bin/dev"
    
}

unlink_project(){
    perform_task "removing symbolic link ..."
    execute  "sudo" "rm" "-fv" "${local_executable}/bin/dev"

}
# move_project(){
#     echo -e "$yellow coping project... $end"
#     cp -r ./src/tuzue ./sample_project
#     # echo -e "$yellow Moving project to /usr/local/bin $end"
# }

move_dir(){
    perform_task "moving directory src/tuzue..."
    mv tuzue/src/tuzue ./_tuzue
    rm -rf tuzue
    mv _tuzue tuzue

}

install_tuzue(){
  if [ -d "./tuzue" ]; then
    warn "tuzue already installed"
    else
      perform_task "installing tuzue..."
      execute "git" "clone" "https://github.com/lpenz/tuzue.git"
      move_dir
      exit 0

  fi

}

# this is for python to use.
if [[ "${1-}" =~ ^-*l(link)?$ ]]; then
    link_project
    exit 0
elif [[ "${1-}" =~ ^-*u(nlink)?$ ]]; then
    unlink_project
    exit 0
fi



if [[ "${1-}" =~ ^-*a(dd)?$ ]]; then
    install_tuzue
    exit 0
elif [[ "${1-}" =~ ^-*r(m)?$ ]]; then
    abort_println "removing tuzue"
    rm -rf tuzue
    exit 0
fi











newline=$'\n'
warn "Note: this script uses symbolic link method in$newline/usr/local/bin on both macOS and Linux."

if [[ -f "${local_executable}/bin/dev" ]]
then
    warn "dev is already installed."
    # ask to remove
    read -p "Do you want to remove it? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        unlink_project
        exit 0
    fi
else
    link_project
    exit 0
fi







