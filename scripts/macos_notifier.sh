#!/bin/bash
#TODO move this file and rename it.


received_message="$1 $2, $3 is $4"
bash /usr/local/bin/terminal-notifier -message "$received_message"
