###  Workflow is a script to setup a Raspberry pi as a server for developement running ubuntu 22.04. Basic minimal setup.

### For web developement docker images will be used. Setting up ngnix, apache, maven etc... usually has ports conflicts, and it is a pain to figure out which program is using which ports. 


RUNNING on ubuntu 22.04 



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

~~- Add mosquitto docker support~~

~~-Setup jailbreak stuff~~


TODO: 

- [ ] setup jailbreak remote
- [ ] get private notification
- [ ] create a backup script








credits: - https://github.com/wong2/pick
- 
