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
if response == "setup":   
    setup_task = ["server","network", "notification"]
    setup = tuzue.navigate(setup_task, "setup task")
    if setup == "server":
        # using an index for quicker debugging
        server_install = ["install_all ", "individual install"].index(tuzue.navigate(["install_all ", "individual install"], "server install"))
        if server_install == 0:
            subprocess.run(['bash',workdir, "-server", "install_all"])
