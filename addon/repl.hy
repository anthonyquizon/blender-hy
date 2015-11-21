(import [threading :as th]
        [socket :as s]
        [hy])

(def HOST "localhost")
(def PORT 9999)
(def RUNNING true)

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

;;csp to thread

(defn thread-handle [socket]
  (while RUNNING
    (let [[conn addr] (socket.accept)
          data (conn.recv 4096)
          data-str (data.decode "utf-8")]
      (print "Connected with" (get addr 0) ":" (get addr 1))
      (print "Recieved:" data-str)
      (print (eval (read-str data-str)))
      )))

(defn create-socket[]
  (let [socket (s.socket s.AF_INET s.SOCK_STREAM)]
    (socket.setsockopt s.SOL_SOCKET s.SO_REUSEADDR 1)
    (try
     (do
      (socket.bind (, HOST PORT))
      (socket.listen 5))
     (except [e s.error] ;;TODO expand error
       (print "Socket bind faild. Error: " e)))
    (print "socket binded to host" HOST "at port" PORT)
    
    ;;TODO send stdout to socket
    
    socket
    ))

(defn register[]
  (let [socket (create-socket)
        thread (apply (. th Thread) [] {:target thread-handle :args (, socket)})]
       (thread.start)
       ))

(defn unregister[]
  (print "blispy repl unregistering"))

(defmain [&rest args]
  (register))
