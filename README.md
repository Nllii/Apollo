###  Workflow is a small script for setup a  Raspberry pi server  for developement running ubuntu 22.04  
TESTED on ubuntu 22.04 

## how to use :
You can manually just set the path to the workflow folder.

```bash 
git clone https://github.com/Nllii/workflow.git
cd workflow
echo "export PATH=\$PATH:$(pwd)" >> ~/.bashrc
chmod +x dev
echo "reloading bashrc ..."
source ~/.bashrc
```
or 

```bash 
git clone https://github.com/Nllii/workflow.git
cd workflow
bash install-workflow.sh

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
