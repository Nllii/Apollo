import os
import re
import yaml
import tuzue  # fuzzy search menu
import subprocess
import threading
from secret_assistant import notification
import queue


STOP_SCRIPT = True
path = os.path.dirname(os.path.realpath(__file__)) + "/scripts/"
notifiy_path = os.path.dirname(os.path.realpath(__file__)) + "/dev.notification.yaml"

def getfile():
    path = os.path.dirname(os.path.realpath(__file__))
    with open(path + "/default.yaml", "r") as f:
        return yaml.full_load(f)

def init():
    try:
        commands = getfile()
        return commands
    except:
        print(
            "Error: Could not load commands.yaml make sure the the spacing is correct"
        )
        quit()


command = init()
def writefile(getList):
	with open(path + "developer_tools.txt", "w") as f:
		for i in getList:
			for key, value in i.items():
				if value is True or value is False:
					f.write(f"{key}: {value}")
					f.write("\n")
				else:
					f.write(f"{key}: {value}")
					f.write("\n")
	return True


def getscript(selected):
    label = []
    _script = []
    _run_ = [info for info in command if re.search(selected, info)].pop()
    if _run_ in command:
        for info in command[_run_]:
            label.extend(info)
            _script.append(info)
    return _script


def fix_scriptpaths(command):
    init_command = command
    getInit = init_command[: init_command.index(" ") + 1]
    path = os.path.dirname(os.path.realpath(__file__))
    command = command[command.index(" ")+1:]
    if path not in command:
        _command =  f"{getInit}/{path}/{command}"
        return _command
    else:
        return command





def run_script(script,select=None):
    # hardcoding this is not a good option... will have to fix this later
    if select == "install all":
        done = writefile(getscript("individual install"))
        if done != True:
            print("Error: Could not write to file")
    try:
        match = re.search(r"<(.*?)>", script)
        if match:
            print("Enter a folder or project name or . :", match.group(0))
            folder = input(">>> ")
            script = script.replace(match.group(0), folder)
        comand = fix_scriptpaths(script)
        subprocess.call(comand, shell=True)
        return select
    except:
        print("Error: from run_script()... Check your config file for errors")


def nextscreen(selected):
    label = []
    _script = []
    _run_ = [info for info in command if re.search(selected, info)].pop()
    if _run_ in command:
        for info in command[_run_]:
            label.extend(info)
            _script.append(info)
        _selection = label.index(
            tuzue.navigate(label, selected.upper().center(50, "-"))
        )
        _selected = label.pop(_selection)
        _Isexecute = _script[_selection][f"{_selected}"]
        if _Isexecute == None:
            return nextscreen(_selected)
        return _selection, _selected, _Isexecute, _script

def navigator(q=None, index=0, title=None):
    title = [info for info in command][index]
    bigger_text = title.upper().center(50, "-")
    label = []
    script = []
    config = [info for info in command]
    for get in config:
        is_command = str(get).endswith(f"command") or str(get).endswith(f"commands")
        if re.search(title, get):
            if is_command == True:
                for i in command[get]:
                    label.extend(i)
                    script.append(i)
    while True:
        selection = label.index(tuzue.navigate(label, bigger_text))
        selected = label.pop(selection)
        excute = script[selection][f"{selected}"]
        while excute == None:
            _selection, _selected, _Isexecute, _script = nextscreen(selected)
            excute = _script[_selection][f"{_selected}"]
            selected = _selected
            script = _script
        else:
            break
    return selected, excute
    # q.put((selected, excute))




selected, excute = navigator()
if selected:
    try:
        q = queue.Queue()
        start = notification(file=notifiy_path,message=f"task run: {str(selected).upper()}")
        start.sendmessage()
    except Exception as e:
        if e.args[0]:
            print("notification file not found or there is an error in the file")
        else:
            nav_thread = threading.Thread(target=start.sendmessage)
            nav_thread.start()
            
	# result = q.get(block=False)
    finally:
        run_script(script=excute,select=selected)
        nav_thread.join()



