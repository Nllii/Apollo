# https://github.com/modoboa/modoboa-installer/blob/master/modoboa_installer/utils.py


import random
import string
import sys
try:
    import configparser
except ImportError:
    import ConfigParser as configparser

ENV = {}
BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE = range(8)


def user_input(message):
    """Ask something to the user."""
    try:
        from builtins import input
    except ImportError:
        answer = raw_input(message)
    else:
        answer = input(message)
    return answer


def has_colours(stream):
    """Check if terminal supports colors."""
    if not hasattr(stream, "isatty"):
        return False
    if not stream.isatty():
        return False  # auto color only on TTYs
    try:
        import curses
        curses.setupterm()
        return curses.tigetnum("colors") > 2
    except:
        # guess false in case of error
        return False





has_colours = has_colours(sys.stdout)
def printcolor(message, color):
    """Print a message using a green color."""
    if has_colours:
        message = "\x1b[1;{}m{}\x1b[0m".format(30 + color, message)
    print(message)





def make_password(length=16):
    """Create a random password."""
    return "".join(
        random.SystemRandom().choice(
            string.ascii_letters + string.digits) for _ in range(length))




printcolor(
    "This script will help you to setup a new Modoboa instance.",
    3
    
)