from pick import pick
import os
import subprocess
#import time 



shell_scripts_dir = os.path.dirname(os.path.abspath(__file__))
shell_scripts= os.path.join(shell_scripts_dir, '_scripts')

def building():
    title = 'BUILDING TASK: '
    options = ['Docker build', 'Docker re - run']
    option, index = pick(options, title, indicator='=>', default_index=0)
    return option, index



def repo_task():
    title = 'REPO TASK: '
    options = ['create a new repo and push']
    option, index = pick(options, title, indicator='=>', default_index=0)
    return option, index




def _admin_task():
    title = 'DEVELOPMENT TASK: '

    options = ['git init','commit','start_django server','run on Docker']
    option, index = pick(options, title, indicator='=>', default_index=0)
    return option, index





option, index = _admin_task()
# print(option, index)

if index == 0:
    repo_option, repo_index = repo_task()
    if repo_index == 0:
        subprocess.call(['bash', shell_scripts + '/scan_project.sh'])
    
    elif index == 2:
        subprocess.call(['bash', shell_scripts + '/start_django.sh'])
    else:
        pass

    if repo_index == 3:
        subprocess.call(['bash', shell_scripts + '/upload_caprover.sh'])
    else:
        pass
elif index == 1:
    commit_option = input("Enter commit message: ")
    subprocess.call(['bash', shell_scripts + '/commit_project.sh', commit_option])
elif index == 2:
    subprocess.call(['bash', shell_scripts + '/start_django.sh'])


elif index == 3:
    option, index = building()
    if index == 0:
        subprocess.call(['bash', shell_scripts + '/docker_task.sh','build_image'])
    if index == 1:
        subprocess.call(['bash', shell_scripts + '/docker_task.sh','run_docker'])


    


