# redmastern@gmail.com
# I am having issues getting setup server: to show, my index is off. Below is my yaml config and python code. How would you fix it?



# # - This is the default.
# developement: jumping # for developement
# developement command:
# - commit: bash scripts/developement.sh commit push
# - kill process: bash scripts/developement.sh kill-process
# - new project:
# - setup server:


# new project: jumping # for new projects
# new project commands:
# - ReactJs: npx create-react-app
# - NextJs:  npx create-next-app@latest





# setup server: jumping # for new projects
# setup server commands:
# - testingA: npx create-react-app
# - testingsB: npx create-next-app@latest




# helps: # a list of help commands to help
# helps command:
# - remove scripts:
# - Give all access to folder:  bash scripts/developement.sh permission


import os
import re
import yaml
import time
import tuzue
import subprocess


STOP_SCRIPT = False

path = os.path.dirname(os.path.realpath(__file__)) + "/scripts/"


def getCommands():
    path = os.path.dirname(os.path.realpath(__file__))
    with open(path + "/commands.yaml", "r") as f:
        return yaml.full_load(f)


def init():
    try:
        commands = getCommands()
        return commands
    except:
        print(
            "Error: Could not load commands.yaml make sure the the spacing is correct"
        )
        quit()


_command_ = init()


def run_script(script):
    try:
        subprocess.call(script, shell=True)
    except:
        print("Error: from run_script()... Check your config file for errors")


def navigator(index=0):
    title = [info for info in _command_][index]
    biggerText = title.upper().center(50, "-")
    config = [info for info in _command_]
    command = []
    script = []
    for get in config:
        # hard coded for now, but its a bad idea to have a command that ends with command or commands being hardcoded.
        is_command = str(get).endswith(f"command") or str(get).endswith(f"commands")
        if re.search(title, get):
            if is_command == True:
                for i in _command_[get]:
                    command.extend(i)
                    script.append(i)
    selection = command.index(tuzue.navigate(command, biggerText))
    return script[selection][f"{command[selection]}"], selection


def run():
    global STOP_SCRIPT
    selected, selection = navigator()
    while STOP_SCRIPT == False:
        if selected == None:
            selected, selection = navigator(index=selection)
        if selected == None:
            print(f"No script found")
            # pass
        else:
            run_script(selected)
            STOP_SCRIPT = True


run()
