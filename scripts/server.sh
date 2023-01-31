# !/bin/bash

set -u
set -o errexit
set -o nounset
set -o pipefail
newline=$'\n'

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
failure() {
  printf "${tty_red}failed${tty_reset}: %s\n" "$(chomp "$1")"
  # exit 0
}
perform_task() {
  printf "${tty_blue}==>${tty_bold} %s${tty_reset}\n" "$(shell_join "$@")"
}

checkOS() {
if [[ "$OS" != "Linux" ]]; then
    warn "${OS} is not completely supported yet only Linux is supported"
		# exit 0


fi
}


install_all()
{
declare -a programs=()
while read line; do
  program=$(echo "$line" | awk -F ':' '{print $2}' | xargs)

	if [ "$program" != "True" ] && [ "$program" != "False" ]; then
			programs+=("$program")
	fi
done < $project_dir/developer_tools.txt

isInstalled=${#programs[@]}
for (( i=0; i<${isInstalled}; i++ ));
do
	if ! command -v "${programs[$i]}" &> /dev/null
	then
		failure "Did not find command $tty_yellow${programs[$i]}$tty_reset on your system"
		else
			perform_task "$tty_yellow${programs[$i]}$tty_reset is already on your system"
	fi
done


}




prevent_sudo() {
	checkOS
	getUsername=$(whoami)
	sudo cp /etc/sudoers /etc/sudoers.bak
	sudo bash -c "echo '$getUsername ALL=(ALL) NOPASSWD: ALL' | (EDITOR='tee -a' visudo)"
	perform_task "sudo permission is removed"
}













"${@:1}" "${@:3}"

