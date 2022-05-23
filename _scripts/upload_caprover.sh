RED='\033[0;31m'
White="\[\033[0;37m\]"
END='\033[0m' 
IYellow="\033[0;93m[x]"     
# echo -e "${RED}Uploading to caprover... \nI have no control after this point...${END}"
account_=$(<credentials.txt)
_name=$(echo $account_ | cut -d " " -f2)
cluster_name=${_name#*=}
_password=$(echo $account_ | cut -d " " -f3)
cluster_password=${_password#*=}
_domain=$(echo $account_ | cut -d " " -f3)
cluster_domain=${_domain#*=}

echo -e "${IYellow}Cluster name: $cluster_name${END}"
echo -e "${IYellow}Cluster password: $cluster_password${END}"
echo  -e "${IYellow}Cluster domain: $cluster_domain${END}"

caprover deploy -h $cluster_domain -p $cluster_password -b main -a $cluster_name