#!/bin/bash

virtualenv addon/env -p python3
source addon/env/bin/activate
pip3 install -r requirements.txt

ln -sf "$(pwd)/addon" "$HOME/Library/Application Support/Blender/2.78/scripts/addons/blender-hy"
