from picker import pick
import os
import subprocess
shell_scripts_dir = os.path.dirname(os.path.abspath(__file__))
shell_scripts= os.path.join(shell_scripts_dir, 'scripts')
# BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE = range(8)
def server_setup():
    title = 'SERVER SETUP TASK: '
    options = ['install everything','install git cli','install docker',

               ]
    option, index = pick(options, title, indicator='=>', default_index=0)
    return option, index
    



def docker_task():
    title = 'DOCKER TASK: '
    options = ['docker build && run', 'docker compose up']
    option, index = pick(options, title, indicator='=>', default_index=0)
    return option, index



def repo_task():
    title = 'REPO TASK: '
    options = ['git commit','create new repo']
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
    elif git_index == 1:
        subprocess.call(['bash', shell_scripts + '/create-repo.sh'])


elif index == 1:
    docker_option, docker_index = docker_task()
    if docker_index == 0:
        subprocess.call(['bash', shell_scripts + '/docker-build.sh', '-build'])
    elif docker_index == 1:
        subprocess.call(['bash', shell_scripts + '/docker-build.sh', '-compose-build'])



elif index == 2:
    server_option, server_index = server_setup()
    print(server_index)
    if server_index == 0:
        subprocess.call(['bash', shell_scripts + '/setup-server.sh', '-everything'])

    
    
    
    




    


