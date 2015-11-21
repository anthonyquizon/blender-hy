import os
import sys
import bpy

addonPath = os.path.abspath(os.path.dirname(__file__))
modulesPath = os.path.abspath(os.path.join(addonPath, "modules"))

sys.path.append(addonPath)
sys.path.append(modulesPath)

import hy
import repl

bl_info = {
    "name": "Blispy",
    "category": "Script"
}


# class ToolsPanel(bpy.types.Panel):
#     bl_label = "Blispy"
#     bl_space_type = "VIEW_3D"
#     bl_region_type = "TOOLS"

#     def draw(self, context):
#         self.layout.operator("blispy.start_repl")


# class OBJECT_OT_BlispyStartRepl(bpy.types.Operator):
#     bl_idname = "blispy.start_repl"
#     bl_label = "Start Blispy REPL"

#     def execute(self, context):
#         repl.hello()
#         return{'FINISHED'}


def register():
    repl.register()
    # bpy.utils.register_module(__name__)


def unregister():
    repl.unregister()
    pass

if __name__ == "__main__":
    register()
