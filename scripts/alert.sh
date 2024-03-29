#!/bin/bash
project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
local_host_name=$(hostname)
date=$(date)
set -u

declare -a address=()

alert()
{
while read line; do
  servers=$(echo "$line" | awk '{print $1}')
	if [ "$servers" != "True" ] && [ "$servers" != "False" ]; then
			address+=("$servers")
	fi
done < $project_dir/ip_address.txt
ip_address=${#address[@]}
for (( i=0; i<${ip_address}; i++ ));
do
  echo "${address[$i]}"
done


}

function send_alert() {
  alert | while read line
  do
    server=$line
    host_name=$(ssh admin@$server "hostname")
    command="~/Apollo/scripts/macos_notifier.sh"
    # SSH into the server and run the command
    result=$(ssh admin@$server "$command "$host_name $line $local_host_name $1 "")
    # Check the result and take action based on the result
    if [ "$result" == "0" ]; then
      echo "Success"
    elif [ "$result" == "1" ]; then
      echo "Failure"
    else
      echo "server $1   @$date"
    fi
  done
}

# I will not check for duplicated entries.
# set a command to run a function.
if [[ $1 == "alert" ]]; then
	echo ""
	read -p 'Enter the IP address to add to list: ' commit
	if [ ! -d "$project_dir/ip_address.txt" ] ; then
		echo $commit >> $project_dir/ip_address.txt
		exit 0

	else
		echo "cant not find ip_address.txt, $project_dir/ip_address.txt."
		exit 1
	fi
fi



send_alert $1 >> $project_dir/log.txt





