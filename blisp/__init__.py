import os
import sys

addonPath = os.path.abspath(os.path.dirname(__file__))
modulesPath = os.path.abspath(os.path.join(addonPath, "modules"))

sys.path.append(addonPath)
sys.path.append(modulesPath)

import hy
import hello

print(hello.hello())

bl_info = {
    "name": "Blisp",
    "category": "Script"
}


def register():
    print("Hello register!")


def unregister():
    print("Hello unregister!")

if __name__ == "__main__":
    register()
