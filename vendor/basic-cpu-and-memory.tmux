#!/usr/bin/env python

"""
Basic CPU & Memory Usage for Tmux

Author: Zaiste! <oh@zaiste.net>

Dash-meter inspired by tmux-mem-cpu
and code from psutil top.py.

From https://github.com/zaiste/tmuxified

Changes by Tony Narlock <tony@git-pull.com> at
https://github.com/tony/tmux-config.
"""

import os
import sys
if os.name != 'posix':
        sys.exit('platform not supported')
import psutil


def get_dashes(perc):
    dashes = "|" * int((float(perc) / 10))
    empty_dashes = " " * (10 - len(dashes))
    return dashes, empty_dashes


def info():
    mem = psutil.virtual_memory()

    cpu_dashes, cpu_empty_dashes = get_dashes(psutil.cpu_percent(interval=0.1))
    line = "{used}/{total}MB [{cpu_dashes}{cpu_empty_dashes}] {loadavg}".format (
        used = str(int(mem.used / 1024 / 1024)),
        total = str(int(mem.total / 1024 / 1024)),
        cpu_dashes = cpu_dashes, cpu_empty_dashes = cpu_empty_dashes,
        cpu_percent = psutil.cpu_percent(interval=0.1),
        loadavg = ' '.join([str(i) for i in os.getloadavg()]),
    )

    return line


def main():
    try:
        print info()
    except (KeyboardInterrupt, SystemExit):
        pass

if __name__ == '__main__':
    main()
