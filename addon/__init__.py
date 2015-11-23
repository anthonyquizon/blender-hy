import os
import sys

addonPath = os.path.abspath(os.path.dirname(__file__))
modulesPath = os.path.abspath(os.path.join(addonPath, "modules"))

sys.path.append(addonPath)
sys.path.append(modulesPath)

import hy
import repl_server
import atexit


bl_info = {
    "name": "Blispy",
    "category": "System",
    "description": "hy lang integration kit"
}


def register():
    repl_server.on_register()


def unregister():
    repl_server.on_unregister()


def exit_handler():
    repl_server.on_exit()

atexit.register(exit_handler)

if __name__ == "__main__":
    register()
