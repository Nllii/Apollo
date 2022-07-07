#!/bin/bash



if [ $1 == "-home" ]; then 
	sudo cp /home/ubuntu/workflow/networks/home/50-cloud-init.yaml /etc/netplan/
fi 



if [ $1 == "-work" ]; then 
	sudo cp /home/ubuntu/workflow/networks/work/50-cloud-init.yaml /etc/netplan/
	# sudo netplan --debug apply
fi 
