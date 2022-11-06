# Copyright (C) 2022 Leandro Lisboa Penz <lpenz@lpenz.org>
# This file is subject to the terms and conditions defined in
# file 'LICENSE', which is part of this source code package.
"""
A View object has the state of a particular view. It's not
necessarily the current view, but it can be so by using the Screen
instance.
"""

import tuzue.input


class View:
    def __init__(self, title="", items=None, generator=None):
        # One of the mutually-exclusive arguments must be provided:
        assert (items is None) != (generator is None)
        # All items:
        self.items_all = items or []
        # item_generator, when in use:
        self.item_generator = generator
        # Effective items, filtered by input:
        self.items = []
        # Selected item, identified by items index:
        self.selected_idx = None
        # Screen height, or number of visible items:
        self.screen_height = None
        # Screen starts at this self.item idx:
        self.screen_idx = None
        # Self-managed input object:
        self.input = tuzue.input.Input()
        # Title, shown in header:
        self.title = title
        # Reset to sync selected_idx with items:
        self.reset()

    def reset(self):
        """
        Reset self.items to self.items_all, as if we had no filter input.
        Reset selected_idx.
        """
        self.items = list(self.items_all) or []
        self.selected_idx = 0 if self.items else None
        self.screen_idx = 0 if self.screen_height else None

    # Item generation methods:

    def item_generate(self):
        """
        Generate one item using self.item_generator, if possible, and append it to
        self.items_all.

        Returns True if an item was generated, or False otherwise - if we are already
        done, for instance.
        """
        if not self.item_generator:
            return False
        try:
            wasempty = self.items == []
            item = next(self.item_generator)
            self.items_all.append(item)
            if self.item_filter(item):
                self.items.append(item)
                if self.selected_idx is None and wasempty:
                    self.selected_idx = 0
            return True
        except StopIteration:
            self.item_generator = None
            return False

    def items_generate_all(self):
        while self.item_generate():
            pass

    # Item filtering methods:

    def item_filter(self, item):
        """Returns True if the provided item should be shown, given the current input"""
        return not self.input.string or self.input.string in item

    def items_update(self):
        """Resets and updates the whole self.items list using the current input;
        also resets selected_idx if necessary"""
        selected_item = None
        if self.selected_idx is not None:
            selected_item = self.items[self.selected_idx]
        self.items = []
        self.selected_idx = None
        idx = 0
        for item in self.items_all:
            if self.item_filter(item):
                self.items.append(item)
                if item == selected_item:
                    self.selected_idx = idx
                idx += 1
        if self.selected_idx is None and self.items:
            self.selected_idx = 0
        if not self.selected_in_screen():
            self.screen_center()

    # Selected idx/items methods:

    def selected_idx_set(self, idx):
        if idx < 0 or idx >= len(self.items):
            return
        self.selected_idx = idx

    def selected_item(self):
        if self.selected_idx is not None:
            return self.items[self.selected_idx]
        return None

    def selected_in_screen(self):
        if self.screen_height is None or self.selected_idx is None:
            return True
        return (
            self.screen_idx <= self.selected_idx
            and self.selected_idx < self.screen_idx + self.screen_height
        )

    # Screen methods, used to generate the concrete view:

    def screen_height_set(self, height):
        old_screen_height = self.screen_height
        self.screen_height = height
        if height != old_screen_height:
            self.reset()

    def screen_items(self):
        screen_idx = self.screen_idx or 0
        for line, item in enumerate(self.items[screen_idx:]):
            if self.screen_height is not None and line >= self.screen_height:
                break
            yield item

    def screen_selected_line(self):
        if self.selected_idx is None:
            return None
        return self.selected_idx - (self.screen_idx or 0)

    def screen_center(self):
        mid = self.screen_height // 2
        self.screen_idx = max(0, self.selected_idx - mid)
        # If we can scroll down to show more items:
        items_len = len(self.items)
        if (
            items_len > self.screen_height
            and self.selected_idx > items_len - self.screen_height
        ):
            self.screen_idx = items_len - self.screen_height

    # Key reactors:

    def typed(self, char):
        self.input.typed(char)
        self.items_update()

    def key_enter(self, key=None, keyname=None):
        return True

    def key_down(self, key=None, keyname=None):
        self.selected_idx_set(self.selected_idx + 1)
        if not self.selected_in_screen():
            self.screen_idx += 1

    def key_up(self, key=None, keyname=None):
        self.selected_idx_set(self.selected_idx - 1)
        if not self.selected_in_screen():
            self.screen_idx -= 1

    def key_pgup(self, key=None, keyname=None):
        self.screen_idx = self.screen_idx - self.screen_height + 1
        if self.screen_idx < 0:
            self.screen_idx = 0
            self.selected_idx_set(0)
        else:
            self.selected_idx_set(self.screen_idx + self.screen_height - 1)

    def key_pgdown(self, key=None, keyname=None):
        self.screen_idx = self.screen_idx + self.screen_height - 1
        if self.screen_idx > len(self.items) - self.screen_height:
            self.screen_idx = len(self.items) - self.screen_height
            self.selected_idx_set(len(self.items) - 1)
        else:
            self.selected_idx_set(self.screen_idx)

    def key_backspace(self, key=None, keyname=None):
        self.input.key_backspace()
        self.items_update()

    def key_delete(self, key=None, keyname=None):
        self.input.key_delete()
        self.items_update()

    def key_left(self, key=None, keyname=None):
        self.input.key_left()

    def key_right(self, key=None, keyname=None):
        self.input.key_right()
