RED='\033[0;31m'
END='\033[0m' # No Color
echo -e "${RED}Uploading to caprover... \nI have no control after this point...${END}"
cluster_name=''
caprover_password=''
caprover deploy -h http://captain.me.cloudships.me -p $caprover_password -b main -a $cluster_name