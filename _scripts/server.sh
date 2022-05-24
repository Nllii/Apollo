#!/bin/bash
# give a list of directory and file to backup
RED='\033[0;31m'
White="\[\033[0;37m\]"
END='\033[0m' 
IYellow="\033[0;93m[x]" 

function server_setup(){
    echo -e "${IYellow} ******* Developer setup setup *******  ${END}"
    sudo apt-get update
    sudo apt-get install -y nginx
    sudo apt-get install -y php7.0-fpm php7.0-mysql php7.0-curl php7.0-gd php7.0-mbstring php7.0-xml php7.0-zip php7.0-bcmath php7.0-json php7.0-opcache php7.0-xmlrpc php7.0-soap php7.0-intl php7.0-ldap php7.0-pgsql php7.0-sqlite3 php7.0-xsl php7.0-mcrypt php7.0-readline
    sudo apt-get install -y php7.0-dev

}