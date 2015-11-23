import os
import sys

addonPath = os.path.abspath(os.path.dirname(__file__))
modulesPath = os.path.abspath(os.path.join(addonPath, "modules"))

sys.path.append(addonPath)
sys.path.append(modulesPath)

import hy
import repl

bl_info = {
    "name": "Blispy",
    "category": "System",
    "description": "hy lang integration kit"
}


def register():
    repl.register()


def unregister():
    repl.unregister()
    pass

if __name__ == "__main__":
    register()
