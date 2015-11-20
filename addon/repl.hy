(import bpy)

;; (defclass ToolsPanel [bpy.types.Panel]
  

;;   )
;; class ToolsPanel(bpy.types.Panel):
;;     bl_label = "Hy Language"
;;     bl_space_type = "VIEW_3D"
;;     bl_region_type = "TOOLS"

;;     def draw(self, context):
;;         self.layout.operator("hy.start_repl")

;; create subprocess

;;TODO register

;; (defn register[]
;;   (print "Hy register"))

;; (defn unregister[]
;;   (print "Hy unregister"))


;;stdout redirect
;;stderr redirect

;; import sys

;; class StdOut(object):
;;     def write(self, string):
;;         sys.__stdout__.write(string)
;;         sys.__stdout__.write(string)
;;         sys.__stdout__.write(string)                
        
;; sys.stdout = StdOut()

;; stdin from socket



(defn hello[]
  (print "hello"))
