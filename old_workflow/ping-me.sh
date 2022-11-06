#!/bin/bash
#https://forums.raspberrypi.com/viewtopic.php?t=75137
# https://forums.raspberrypi.com/viewtopic.php?t=75137#p1605715
BASHTIME=`date +" %T"`
TimeDate_now=`date -d "-5 hours" +"%m-%d-%Y %I:%M %p"`
# # Start of code
SERVER=8.8.8.8
ping -c2 ${SERVER} > /dev/null

#TODO
if [ $? != 0 ] 
then
	echo WiFi all bad, restarting it on ${TimeDate_now} at: ${BASHTIME} >> /tmp/is_online.txt
	sudo ifconfig wlan0 down

	sudo ifconfig wlan0 up
	sleep 30

	echo server was offline  on ${TimeDate_now} at:  ${BASHTIME} >> /tmp/is_online.txt
    ping -c2 ${SERVER} > /dev/null
	if [ $? != 0 ]
	then
		echo WiFi not available bad, restarting  PI on ${TimeDate_now} at: ${BASHTIME} >> /home/ubuntu/workflow/network_issues.txt
		if [[ -f "/home/ubuntu/workflow/is_online/.home" ]]; then
			# echo "switching from home to work "
			rm /home/ubuntu/workflow/is_online/.home
			echo trying to connect to work network ${TimeDate_now} at:  ${BASHTIME} >> /home/ubuntu/workflow/network_issues.txt
			sudo bash /home/ubuntu/workflow/is_online/swap_network.sh -work
			touch /home/ubuntu/workflow/is_online/.work
			cd /etc/netplan/ 
			sudo netplan apply
			sleep 10 # this is a safety measure in case the dns is offline or google is no more to prevent endless looping: 
			sudo reboot

		else
			# echo "switching from work to home "
			rm /home/ubuntu/workflow/is_online/.work
			# echo "switching from work to home " >> /tmp/is_online.txt
			echo trying to connect to home network ${TimeDate_now} at:  ${BASHTIME} >> /home/ubuntu/workflow/network_issues.txt
			sudo bash /home/ubuntu/workflow/is_online/swap_network.sh -home
			touch /home/ubuntu/workflow/is_online/.home
			cd /etc/netplan/ 
			sudo netplan apply
			sleep 10 # this is a safety measure in case the dns is offline or google is no more to prevent endless looping: 
			sudo reboot
		fi
		echo switched networks on ${TimeDate_now} at:  ${BASHTIME} >> /tmp/is_online.txt
	fi

else
# If all is good this is written to a text file.  I'll reduce this to only having one line kept becuase later
	echo server is online script run at ${TimeDate_now} at:  ${BASHTIME} >> /tmp/is_online.txt
    
fi

/home/ubuntu/mambaforge/bin/python /home/ubuntu/workflow/send-notifications.py
sleep 10