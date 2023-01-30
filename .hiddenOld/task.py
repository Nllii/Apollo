import tuzue
import subprocess
import os
from  secret_assistant import notification

PROJECT_PATH = os.path.dirname(os.path.abspath(__file__))
_scripts_ = os.path.join(PROJECT_PATH, 'scripts')
_install_ = f'{_scripts_}/install.sh'
developement = f'{_scripts_}/developer_task.sh'
docker_developement = f'{_scripts_}/docker_task.sh'
_list_programs_= './programs.txt'

def completed_task(taskname,message=None):
    notification( f'{taskname}  {message}').info().sendmessage().send_mail()

softwares = []
internal_programs = []
def services():
    # read the text file
    with open(_list_programs_, 'r') as f:
        lines = f.readlines()
    for line in lines:
        line = line.strip()
        line = line.split()
        program = line[0]
        args = line[2]
        _installed_ = {program}
        softwares.extend(_installed_)
        internal_programs.append({"program":program,"args":args})
            
    # return softwares
        
        



developerment_task = [
    "commit",
    "docker",
    "help",
    "server setup"
    
]

docker_task = ['docker build && run',
               'docker compose up', 
               'update containers restart to - always'
               
               ]
help_task = ["remove/install this script",
             "All access chmod -R a+rwx * this directory",
            "disable sudo password",
            "install individual packages",
            "install all packages"
             ]


dev_task = developerment_task.index(tuzue.navigate(developerment_task, "development task"))
(...)
if dev_task == 0:
    #TODO: add more git commands
	subprocess.run(['bash',f'{developement}', "server", "gitadd","commit"])
(...)
if dev_task == 1:
    dev_task_docker = docker_task.index(tuzue.navigate(docker_task, "docker task"))
    if dev_task_docker == 0:
        subprocess.run(['bash',f'{docker_developement}',"-build"])
    if dev_task_docker == 1:
        subprocess.run(['bash',f'{docker_developement}', "-compose-build"])
    if dev_task_docker == 2:
        subprocess.run(['bash',f'{docker_developement}', "-update-containers"])
(...)
if dev_task == 2:
    project_help = help_task.index(tuzue.navigate(help_task, "help task"))
    if project_help == 0:
        subprocess.run(['bash',f'{_install_}'])
    if project_help == 1:
        subprocess.run(['bash',f'{developement}', "server", "permission"])
    if project_help == 2:
        subprocess.run(['bash',f'{developement}', "server", "prevent_sudo"])
    
    if project_help == 3:
        services()
        individual_install = softwares.index(tuzue.navigate(softwares, "individual install"))
        status  = internal_programs[individual_install]
        _status_ = status['args']
        _program_ = status['program']
        subprocess.run(['bash',f'{developement}', "server", "install", _program_, _status_])