#!/bin/bash
# this script checks if my raspberry pi is running if not just reboot! if it comes online. Send a notification to my phone!
while true; do
    wget -q --spider https://google.com 
    if [ $? -eq 0 ]; then
        echo "Online"
        # break
    else
        echo "Offline"
        sudo reboot
    fi
    sleep 200
done
