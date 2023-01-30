# Copyright (C) 2022 Leandro Lisboa Penz <lpenz@lpenz.org>
# This file is subject to the terms and conditions defined in
# file 'LICENSE', which is part of this source code package.
"""
"inspect" function that is specially useful in PDB
"""

import collections.abc as abc

import tuzue


def process(objdict, key, value, f=repr, pre="[", pos="]"):
    item = "%s%s%s = %s" % (pre, f(key), pos, repr(value))
    path = "%s%s%s" % (pre, f(key), pos)
    objdict[item] = (path, value)
    return item


def identity(x):
    return x


def generator(obj, objdict):
    yield "."
    yield ".."
    if isinstance(obj, abc.Mapping):
        for key, value in obj.items():
            yield process(objdict, key, value)
    elif isinstance(obj, abc.Sequence):
        for key, value in enumerate(obj):
            yield process(objdict, key, value)
    for key in dir(obj):
        if not key.startswith("_"):
            value = getattr(obj, key)
            yield process(objdict, key, value, identity, ".", "")
    for key in dir(obj):
        if key.startswith("_"):
            value = getattr(obj, key)
            yield process(objdict, key, value, identity, ".", "")


class Inspector:
    def __init__(self, ui):
        self.ui = ui
        self.done = False
        self.result = None

    def inspect(self, path0, obj, lvl=0):
        objdict = {}
        view = tuzue.view.View(title="".join(path0), generator=generator(obj, objdict))
        while not self.done:
            done = False
            while not done:
                self.ui.show(view)
                done = self.ui.interact(view)
            obj = view.selected_item()
            if obj == ".":
                self.done = True
                return
            if obj == "..":
                if lvl == 0:
                    self.done = True
                return
            objdata = objdict[obj]
            path = list(path0)
            path.append(objdata[0])
            self.result = (path, objdata[1])
            self.inspect(path, objdata[1], lvl + 1)


def inspect(obj=None, name=None):
    if obj is None:
        obj = globals()
    result = None
    path = []
    if name:
        path = [name]
    with tuzue.ui.curses.context() as ui:
        inspector = Inspector(ui)
        result = None
        while not inspector.done:
            inspector.inspect(path, obj)
        result = inspector.result
    print("".join(result[0]), "=", repr(result[1]))
    return result
