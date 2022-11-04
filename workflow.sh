
#!/bin/bash
# https://docs.brew.sh/Installation
# https://sharats.me/posts/shell-script-best-practices/

set -u
set -o errexit
set -o nounset
set -o pipefail
OS="$(uname)"
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi


server_config(){
    echo "pass"
}



if [ $1 == "-server" ]; then 
    if [[ "${OS}" == "Darwin" ]]
    then
        echo "server can only be config on Linux system not ${OS}"
        # exit 1
        else
        server_config
    fi
fi