import tuzue
import subprocess
import os
from  secret_assistant import notification

# notification("testing notifications").info().sendmessage().send_mail()
PROJECT_PATH = os.path.dirname(os.path.abspath(__file__))
workdir = f"{PROJECT_PATH}/workflow.sh"
_install_ =  f"{PROJECT_PATH}/install.sh"
def py_quirk():
    import this


def link_private_repo():
    pass


def link_public_repo():
    pass



def individual_install():

	pass




dev_task = ["commit ", "setup","workflow-config"].index(tuzue.navigate(["commit ", "setup","workflow-config"], "development task"))
if dev_task == 0:
	subprocess.run(['bash',workdir, "server", "commit","commiting"])
elif dev_task == 1:
    pass
elif dev_task == 2:
	workflow_config = ["remove",""].index(tuzue.navigate(["remove"], "remove this script ? "))
	if workflow_config == 0:
		subprocess.run(['bash',_install_])






#     # if setup == "server":
#     #     # using an index for quicker debugging
#     #     server_install = ["install_all ", "individual install"].index(tuzue.navigate(["install_all ", "individual install"], "server install"))
#     #     if server_install == 0:
#     #         subprocess.run(['bash',workdir, "server", "server_config","install_all"])
#     #     elif server_install == 1:
#     #         subprocess.run(['bash',workdir, "server", "server_config","individual"])

