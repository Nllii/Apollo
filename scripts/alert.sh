#!/bin/bash
project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
local_host_name=$(hostname)

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

    # message="message from ubuntu, server is online."
    command="/Users/admin/Apollo/macos_notifier.sh"
    # SSH into the server and run the command
    # hello $local_host_name $line, $local_host_name is $1

    result=$(ssh admin@$server "$command "$host_name $line $local_host_name $1"")
		# echo $result

    # Check the result and take action based on the result
    if [ "$result" == "0" ]; then
      echo "Success"
    elif [ "$result" == "1" ]; then
      echo "Failure"
    else
      echo "$1"
    fi
  done
}
send_alert $1 >> $project_dir/log.txt



