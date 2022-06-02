from picker import pick
import os
import subprocess
#import time 

shell_scripts_dir = os.path.dirname(os.path.abspath(__file__))
shell_scripts= os.path.join(shell_scripts_dir, 'scripts')

def server_setup():
    title = 'SERVER SETUP TASK: '
    options = ['install everything','install git cli','install docker',

               ]
    option, index = pick(options, title, indicator='=>', default_index=0)
    return option, index
    



def docker_task():
    title = 'DOCKER TASK: '
    options = ['docker build', 'Docker re - run']
    option, index = pick(options, title, indicator='=>', default_index=0)
    return option, index



def repo_task():
    title = 'REPO TASK: '
    options = ['git commit']
    option, index = pick(options, title, indicator='=>', default_index=0)
    return option, index






def _admin_task():
    title = 'DEVELOPMENT TASK: '
    options = ['git','docker','server-setup']
    option, index = pick(options, title, indicator='=>', default_index=0)
    return option, index



option, index = _admin_task()
if index == 0:
    git_option, git_index = repo_task() 
    if git_index == 0:
        ask_input = input('Enter commit message: ')
        subprocess.call(['bash', shell_scripts + '/git_commit.sh', str(ask_input)])
    else:
        pass

elif index == 1:
    docker_option, docker_index = docker_task()
    if docker_index == 0:
        subprocess.call(['bash', shell_scripts + '/docker-build.sh', '-build'])

        

    
    
    
    
    
    # server_option, server_index = server_setup()
    # if server_index == 0:
    #     subprocess.call(['bash', shell_scripts + '/setup-server.sh', '-everything'])


#     elif index == 2:
#         subprocess.call(['bash', shell_scripts + '/start_django.sh'])
#     else:
#         pass

#     if repo_index == 3:
#         subprocess.call(['bash', shell_scripts + '/upload_caprover.sh'])
#     else:
#         pass
# elif index == 1:
#     commit_option = input("Enter commit message: ")
#     subprocess.call(['bash', shell_scripts + '/commit_project.sh', commit_option])
# elif index == 2:
#     subprocess.call(['bash', shell_scripts + '/start_django.sh'])


# elif index == 3:
#     option, index = building()
#     if index == 0:
#         subprocess.call(['bash', shell_scripts + '/docker_task.sh','build_image'])
#     if index == 1:
#         subprocess.call(['bash', shell_scripts + '/docker_task.sh','run_docker'])


    


