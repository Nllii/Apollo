import tuzue
import subprocess
from  secret_assistant import notification

# notification("testing notifications").info().sendmessage().send_mail()
workdir = "./workflow.sh"
def py_quirk():
    import this


def link_private_repo():
    pass


def link_public_repo():
    pass


tools = ["setup"]
response = tuzue.navigate(tools, "developer task")
if response == 'setup':   
    setup_task = ["server","network", "notification"]
    setup = tuzue.navigate(setup_task, "setup task")
    if setup == 'server':
        response = subprocess.call(['bash', workdir ,'-server'])
        if response == 0:
            server_install = ["disable sudo","install all ", "individual install"]
            setup_server = tuzue.navigate(server_install, "setup task")
            if setup_server == 'disable sudo':
                response = subprocess.call(['bash', workdir ,'-disable sudo'])
                if response == 0:
                    print("sudo disabled")
                else:
                    print("sudo not disabled")



        # dev_env_task = ["pyenv", "pyenv-virtualenv"]
        # dev_env = tuzue.navigate(dev_env_task, "dev environment")
        # if dev_env == 'pyenv':
        #     pass
        # elif dev_env == 'pyenv-virtualenv':
        #     pass
