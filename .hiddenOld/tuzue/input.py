# Copyright (C) 2022 Leandro Lisboa Penz <lpenz@lpenz.org>
# This file is subject to the terms and conditions defined in
# file 'LICENSE', which is part of this source code package.
"""
An Input object has the state of the input line
"""


class Input:
    def __init__(self, string=""):
        self.string = string
        self.pos = len(string)

    def typed(self, char):
        self.string = self.string[: self.pos] + char + self.string[self.pos :]
        self.pos += 1

    def key_backspace(self):
        if self.string and self.pos > 0:
            self.string = self.string[: self.pos - 1] + self.string[self.pos :]
            self.pos -= 1

    def key_delete(self):
        if self.string and self.pos < len(self.string):
            self.string = self.string[: self.pos] + self.string[self.pos + 1 :]

    def key_left(self):
        if self.string and self.pos > 0:
            self.pos -= 1

    def key_right(self):
        if self.pos < len(self.string):
            self.pos += 1
