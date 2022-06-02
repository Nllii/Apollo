###  Workflow is a script to setup a Raspberry pi as a server for developement running ubuntu 22.04. Basic minimal setup.
TESTED on ubuntu 22.04 




## how to use :
You can manually just set the path to the workflow folder.
and call 
```bash 
dev 
```
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




scripts added: 

- Added commit project
- Added github support
- Add start django server
- Added Docker script 
- Added Portainer
- Add golang 
- Add mosquitto docker support 






credits: - https://github.com/wong2/pick
