import tuzue
import subprocess
import os
from  secret_assistant import notification

# notification("testing notifications").info().sendmessage().send_mail()
PROJECT_PATH = os.path.dirname(os.path.abspath(__file__))
_workdir_ = f"{PROJECT_PATH}/workflow.sh"
_install_ =  f"{PROJECT_PATH}/install.sh"
def py_quirk():
    import this


def deadlock():
	pass



def link_public_repo():

    pass





def link_private_repo():
    pass








dev_task = ["commit ", "setup","help"].index(tuzue.navigate(["commit ", "setup","help"], "development task"))
if dev_task == 0:
	(...)
	subprocess.run(['bash',_workdir_, "server", "commit","commiting"])

elif dev_task == 1:
	server_install = ["- install all ", "- individual install","- only important stuff"].index(tuzue.navigate(["- install all ", "- individual install","- only important stuff"], "server install"))
	if server_install == 0:
		# (...)
		subprocess.run(['bash',_workdir_, "server", "server_config","install_all"])
	elif server_install == 1:
		# (...)
		individual_install = ["docker","portainer","github_cli","cockpit"].index(tuzue.navigate(["docker","portainer","github_cli","cockpit"], "individual task"))

		subprocess.run(['bash',_workdir_, "server", "server_config","individual"])

	elif server_install == 2:
		(...)
		subprocess.run(['bash',_workdir_, "server", "server_config","important"])

elif dev_task == 2:
	workflow_config = ["remove this script","give all access to folder"].index(tuzue.navigate(["remove this script","give all access to folder"], "remove this script ? "))
	if workflow_config == 0:
		subprocess.run(['bash',_install_])
	elif workflow_config == 1:
		subprocess.run(['bash',_workdir_, "server", "permission"])


