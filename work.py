import tuzue
import subprocess


def py_quirk():
    import this


def link_private_repo():
    pass


def link_public_repo():
    pass


tools = ["setup"]
get_response = tuzue.navigate(tools, "sample programmer quirks and setup")
if get_response == 'python':
    python_quirks = ["import this", "import antigravity", "import __hello__"]
    quirks = tuzue.navigate(python_quirks, "python quirks")
