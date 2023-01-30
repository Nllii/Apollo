import os
import re
import yaml
import tuzue # similar to input() but with a fuzzy search
import subprocess

STOP_SCRIPT = False
path = os.path.dirname(os.path.realpath(__file__)) + "/scripts/"
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
def run_script(script):
    try:
        match = re.search(r"<(.*?)>", script)
        if match:
            print("Enter a folder or project name or . :", match.group(0))
            folder = input(">>> ")
            script = script.replace(match.group(0), folder)
        subprocess.call(script, shell=True)
    except:
        print("Error: from run_script()... Check your config file for errors")
	# run_script("npx create-react-app <project-directory>")


def navigator(index=0, title=None):
    # task  = []
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

    selection = label.index(tuzue.navigate(label, bigger_text))
    selected = label.pop(selection)
    Isexecute = script[selection][f"{selected}"]
    if Isexecute == None:
        label.clear()
        script.clear()
        _run_ = [info for info in command if re.search(selected, info)].pop()
        if _run_ in command:
            for info in command[_run_]:
                label.extend(info)
                script.append(info)
        _selection = label.index(tuzue.navigate(label, selected.upper().center(50, "-")))
        _selected = label.pop(_selection)
        _Isexecute = script[_selection][f"{_selected}"]
        run_script(_Isexecute)
    else:
        run_script(Isexecute)



navigator()
