# Copyright (C) 2022 Leandro Lisboa Penz <lpenz@lpenz.org>
# This file is subject to the terms and conditions defined in
# file 'LICENSE', which is part of this source code package.
"""
UiCurses class that represents the full state of the curses screen
itself and is able to sync it with the provided view.

Should be instantiated as a singleton.

This class is used to display a particular View instance, and allows
us to have several views on the stack and switch between then
efficiently. It serves as a bridge between the View class and the
downstream ui implementation - but for now only curses is available.
"""


import curses
from contextlib import contextmanager

from tuzue.view import View


class CursesError(Exception):
    pass


class CursesWin:
    """Class that encapsulates a curses window"""

    def __init__(self, label, height, width, line, col):
        self.height = height
        self.width = width
        self.line = line
        self.col = col
        self.label = label
        self.win = curses.newwin(height, width, line, col)

    def erase(self):
        self.win.erase()

    def noutrefresh(self):
        self.win.noutrefresh()

    def addstr(self, line, col, string, *args):
        available = self.width - col
        if len(string) > available:
            string = string[0 : (self.width - col - 4)] + "..."
        try:
            self.win.addstr(line, col, string, *args)
        except curses.error:
            raise CursesError("win {} could not addstr {}\n".format(self.label, string))

    def set_cursor(self, line, col):
        curses.setsyx(self.line + line, self.col + col)


@contextmanager
def winfocus(win):
    """Window context - makes the code more ergonomic and
    schedules an update upon exit"""
    try:
        yield win
    finally:
        win.noutrefresh()


class Windows:
    """The standard collection of windows we use, for ergonomy"""

    def __init__(self):
        self.title = None
        self.prompt = None
        self.input = None
        self.menu = None


class UiCursesBase:
    """
    Base classe for the curses UI that provides the functionality but not the layout.

    Derived classes should def layout(self), override the prompt, etc.
    They can also def input_process to provide additional bindings.
    """

    prompt = "> "
    edit_actions = {}
    edit_actions_default = {
        b"KEY_ENTER": View.key_enter,
        b"KEY_DOWN": View.key_down,
        b"KEY_UP": View.key_up,
        b"KEY_PPAGE": View.key_pgup,
        b"KEY_NPAGE": View.key_pgdown,
        b"KEY_BACKSPACE": View.key_backspace,
        b"KEY_DC": View.key_delete,
        b"KEY_LEFT": View.key_left,
        b"KEY_RIGHT": View.key_right,
    }

    def __init__(self):
        self.stdscr = None
        self.win = Windows()

    def start(self):
        """
        Based on
        https://github.com/enthought/Python-2.7.3/blob/master/Lib/curses/wrapper.py
        """
        # Initialize curses
        self.stdscr = curses.initscr()
        # Turn off echoing of keys, and enter cbreak mode,
        # where no buffering is performed on keyboard input
        curses.noecho()
        curses.cbreak()
        # In keypad mode, escape sequences for special keys
        # (like the cursor keys) will be interpreted and
        # a special value like curses.KEY_LEFT will be returned
        self.stdscr.keypad(True)
        # Start color, too.  Harmless if the terminal doesn't have
        # color; user can test with has_color() later on.  The try/catch
        # works around a minor bit of over-conscientiousness in the curses
        # module -- the error return from C start_color() is ignorable.
        try:
            curses.start_color()
            # Reset colors to default
            curses.use_default_colors()
        except Exception:
            pass
        self.layout()

    def end(self):
        if not self.stdscr:
            return
        # Set everything back to normal
        if curses.has_colors():
            curses.use_default_colors()
        self.stdscr.keypad(0)
        curses.echo()
        curses.nocbreak()
        curses.endwin()

    def layout(self):
        raise NotImplementedError

    def max_items(self):
        return self.win.menu.height

    def show(self, view):
        # Update menu:
        with winfocus(self.win.menu) as win:
            win.erase()
            view.screen_height_set(self.max_items())
            for i, item in enumerate(view.screen_items()):
                win.addstr(i, 0, item)
            if view.screen_selected_line() is not None:
                win.addstr(
                    view.screen_selected_line(),
                    0,
                    view.selected_item(),
                    curses.A_REVERSE,
                )
        # Update input:
        with winfocus(self.win.input) as win:
            win.erase()
            win.addstr(0, 0, view.input.string)
        # Update title, with status:
        with winfocus(self.win.title) as win:
            win.erase()
            win.addstr(0, 0, view.title)
            status = "%s/%d" % (
                str(
                    view.selected_idx + 1
                    if view.selected_idx is not None
                    else view.selected_idx
                ),
                len(view.items),
            )
            win.addstr(0, win.width - len(status) - 1, status)
        # Position cursor in prompt:
        self.win.prompt.set_cursor(0, len(self.prompt) + view.input.pos)
        # Refresh screen:
        curses.doupdate()

    def input_read(self, nodelay):
        self.win.input.win.nodelay(nodelay)
        key = self.win.input.win.getch()
        if key == -1:
            return key, None
        keyname = curses.keyname(key)
        if key == 27:
            self.win.input.win.nodelay(True)
            k = self.win.input.win.getch()
            if k != -1:
                keyname += curses.keyname(k)
        return key, keyname

    def interact(self, view):
        # Generate first item:
        view.item_generate()
        # Set nonblocking if we have more items to generate, otherwise
        # set blocking mode:
        key, keyname = self.input_read(bool(view.item_generator))
        return self.input_process(view, key, keyname)

    def input_process(self, view, key, keyname):
        # for keyname, action in self.edit_actions.items(): backspace.
        if key == 127:
            keyname = b"KEY_BACKSPACE"
            
        if keyname in self.edit_actions:
            self.edit_actions[keyname](view)
        elif keyname in self.edit_actions_default:
            self.edit_actions_default[keyname](view)
            
        if key == -1:
            return False
        if key in {curses.KEY_ENTER, 10, 13}:
            # If the user hit ENTER, we are done
            key = curses.KEY_ENTER
            keyname = b"KEY_ENTER"
        # Check if it's a custom edit_action
        action = self.edit_actions.get(keyname)
        if action:
            return action(view, key, keyname)
        # Check if it's a default edit_action
        action = self.edit_actions_default.get(keyname)
        if action:
            return action(view, key, keyname)
        # Otherwise, check if it's a regular typed char:
        char = None
        try:
            char = chr(key)
        except ValueError:
            pass
        if char and char.isprintable():
            view.typed(char)
        return False


class UiCursesSimple(UiCursesBase):
    """
    Provides the following layout:

    title----------------------------
    prompt- input--------------------
    menu-----------------------------
    |||||||||||||||||||||||||||||||||
    |||||||||||||||||||||||||||||||||
    """

    def layout(self):
        lines = curses.LINES
        cols = curses.COLS
        self.win.title = CursesWin("title", 1, cols, 0, 0)
        with winfocus(CursesWin("prompt", 1, len(self.prompt) + 1, 1, 0)) as win:
            win.addstr(0, 0, self.prompt)
            self.win.prompt = win
        inputwidth = cols - len(self.prompt)
        with winfocus(CursesWin("input", 1, inputwidth, 1, len(self.prompt))) as win:
            win.win.keypad(True)
            self.win.input = win
        menulines = lines - 2
        self.win.menu = CursesWin("menu", menulines, cols, 2, 0)


@contextmanager
def context(uiclass=UiCursesSimple):
    ui = uiclass()
    try:
        ui.start()
        yield ui
    finally:
        ui.end()


def main():
    with context() as ui:
        items = [str(i) * 10 for i in range(0, ui.max_items())]
        ui.set("> ", items)
        ui.refresh()
        ui.getkey()


if __name__ == "__main__":
    main()
