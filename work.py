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



def individual_install():

	pass




dev_task = ["commit ", "setup","project-task"].index(tuzue.navigate(["commit ", "setup"], "install"))
if dev_task == 0:
	subprocess.run(['bash',workdir, "server", "commit","commiting"])
    # setup_task = ["commit","network", "notification","server"]
    # setup = tuzue.navigate(setup_task, "setup task")
    # if setup == "commit":







    # if setup == "server":
    #     # using an index for quicker debugging
    #     server_install = ["install_all ", "individual install"].index(tuzue.navigate(["install_all ", "individual install"], "server install"))
    #     if server_install == 0:
    #         subprocess.run(['bash',workdir, "server", "server_config","install_all"])
    #     elif server_install == 1:
    #         subprocess.run(['bash',workdir, "server", "server_config","individual"])

