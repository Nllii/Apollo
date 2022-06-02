###  Workflow is a script to setup a Raspberry pi as a server for developement running ubuntu 22.04. Basic minimal setup.

### For web developement docker images wil be used. Setting up ngnix, apache, maven etc... usually crashes the Raspberry pi, the is going to be a huge config of open ports that need to be fix. To avoid this; do everything in docker before moving to your machine.

TESTED on ubuntu 22.04 


experienced linux users Note:

Yo... you can manually just set the path to the workflow folder in any shell . , give script dev a chmod x or u or both permission to execute, and call script $dev , test it in tmux session.

To uninstall, just delete the path and the project folder. 
This script doesn't touch /usr or /opt or /bin to prevent root calling some project path in your home or some where else on your system. 





```bash 
git clone https://github.com/Nllii/workflow.git
cd workflow
echo "export PATH=\$PATH:$(pwd)" >> ~/.bashrc
chmod +x dev
echo "reloading your bashrc ..."
source ~/.bashrc
logout

```
or 

```bash 
git clone https://github.com/Nllii/workflow.git
cd workflow
bash install-workflow.sh
logout and login again 

```

## how to use :
```bash 
#call dev in terminal 
(base) ubuntu@ubuntu: dev
```




scripts added: 

- Added commit project
- Added github support
- Add start django server
- Added Docker script 
- Added Portainer
- Add golang 
- Add mosquitto docker support 
~~-Setup jailbreak stuff~~







credits: - https://github.com/wong2/pick
