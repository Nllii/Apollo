# Copyright (C) 2022 Leandro Lisboa Penz <lpenz@lpenz.org>
# This file is subject to the terms and conditions defined in
# file 'LICENSE', which is part of this source code package.

import tuzue.ui.curses
import tuzue.view

__version__ = "0.0.1"


def navigate(struct, title=""):
    view = tuzue.view.View(items=struct, title=title)
    done = None
    with tuzue.ui.curses.context() as ui:
        while not done:
            ui.show(view)
            done = ui.interact(view)
    return view.selected_item()
