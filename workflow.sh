# !/bin/bash
# https://docs.brew.sh/Installation
# https://sharats.me/posts/shell-script-best-practices/
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
abort_println() {
  printf "${tty_red}performing${tty_reset}: %s\n" "$(chomp "$1")"
  # exit 0
}
perform_task() {
  printf "${tty_blue}==>${tty_bold} %s${tty_reset}\n" "$(shell_join "$@")"
}

# declare -a important=(
# "docker"
# "portainer"
# "github_cli"
# "cockpit"

# )
# important_=${#important[@]}
# echo "installing the important stuff first"
# # use for loop to read all values and indexes
# for (( i=0; i<${important_}; i++ ));
# do
#   # check to see if its important with the .important file
#   if [[ -f "$SERVER_DIR/services/${important[$i]}/.is_important" ]]; then
#     if [[ -f "$SERVER_DIR/services/${important[$i]}/.enable" ]]; then
#       echo -e $MAGENTA
#       echo "${important[$i]} already enabled."
#       echo -e $REST
#     else
#       echo -e $YELLOW
#       echo "installing ${important[$i]}"
#       make -s -C "$SERVER_DIR/services/${important[$i]}" is_script
#       echo "adding .enabled to directory"
#       make -s -C "$SERVER_DIR/services/${important[$i]}"
#       echo -e $REST
#     fi
#   fi
# done


important_install(){
	perform_task "installing the important stuff"
	# use for loop to read all values and indexes
	for (( i=0; i<${important_}; i++ ));
	do
		# check to see if its important with the .important file
		if [[ -f "$project_dir/services/${important[$i]}/.is_important" ]]; then
			if [[ -f "$project_dir/services/${important[$i]}/.enable" ]]; then
				perform_task "${important[$i]} already enabled."
			else
				perform_task "enabling ${important[$i]}"
				execute "$project_dir/services/${important[$i]}/enable.sh"
			fi
		else
			perform_task "skipping ${important[$i]}"
		fi
	done
}

permission(){
	current_dir=$(pwd)
	perform_task "adding permission using sudo chmod -R a+rwx $current_dir"
	execute sudo chmod -R a+rwx $current_dir
}

install_all(){
    perform_task "installing all"

}

individual_install(){
		perform_task "individual install"
}


server_config(){
    if [[ "${1-}" =~ ^-*(install_all)?$ ]]; then
				install_all
        # perform_task "$1ing is the server config"
    fi

    if [[ "${1-}" =~ ^-*individual?$ ]]; then
				individual_install
        # perform_task "$1 is the server config bye"
    fi
}



commit(){
	    if [[ "${1-}" =~ ^-*commiting?$ ]]; then
			perform_task "Enter your commit message"
			read -p ":" commit_message
			perform_task "commit message: $newline$commit_message"
			git add .
			git commit -m "$commit_message"
			git push
		fi

}




if [[ $1 == "server" ]]; then
		# echo "${@:2}" "${@:3}" "${@:4}"
		# if OS and command is server
    if [[ "${OS}" == "Darwin" && "${@:3}" == "install_all" ]]; then
        warn "this can only be used on Linux system not ${OS} - why not try the individual install"
        exit 0
        else
				"${@:2}" "${@:3}"
    fi
fi
