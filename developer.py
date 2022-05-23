from pick import pick
import os
import subprocess
shell_scripts_dir = os.path.dirname(os.path.abspath(__file__))
shell_scripts= os.path.join(shell_scripts_dir, '_scripts')

def repo_task():
    title = 'REPO TASK: '
    options = ['create a new repo and push', 'commit repo', 'git push origin master']
    option, index = pick(options, title, indicator='=>', default_index=0)
    return option, index




def _admin_task():
    title = 'DEVELOPMENT TASK: '
    options = ['git init','commit']
    option, index = pick(options, title, indicator='=>', default_index=0)
    return option, index
    # print(option, index)





option, index = _admin_task()
if index == 0:
    repo_option, repo_index = repo_task()
    if repo_index == 0:
        subprocess.call(['bash', shell_scripts + '/scan_project.sh'])
    
elif index == 1:
    subprocess.call(['bash', shell_scripts + '/commit_project.sh'])