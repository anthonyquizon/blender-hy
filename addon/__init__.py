import os
import sys

addonPath = os.path.abspath(os.path.dirname(__file__))
modulesPath = os.path.abspath(os.path.join(addonPath, "modules"))

sys.path.append(addonPath)
sys.path.append(modulesPath)

import hy
import main

bl_info = {
    "name": "Blispy",
    "category": "Development",
    "description": "hy lang integration kit"
}

def register():
    main.register()


def unregister():
    main.unregister()

if __name__ == "__main__":
    register()
