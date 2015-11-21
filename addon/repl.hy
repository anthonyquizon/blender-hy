(import [threading :as th]
        [socket :as s]
        [sys]
        [hy])

(def HOST "localhost")
(def PORT 9993)
(def ENCODING "utf-8")
(def BUFFER_SIZE 4096)
(def RUNNING true)

;;TODO stdout redirect
;;TODO stderr redirect

;; class StdOut(object):
;;     def write(self, string):
;;         place into buffer
;;         sys.__stdout__.write(string)

;; TODO error buffer
        
;; sys.stdout = StdOut()

(defn send [conn data]
  (conn.send (data.encode ENCODING)))

(defn process-input [socket]
  (let [[conn addr] (socket.accept)
        data (conn.recv BUFFER_SIZE)
        data-str (data.decode "utf-8")]
    (print "Connected with" (get addr 0) ":" (get addr 1))
    (print "Recieved:" data-str)
    
    (try
     (let [result (eval (read-str data-str))]
       (send conn (str result)))
     (except []
       (send conn "eval error")
       (print "eval error")))))
  
(defn thread-handle [socket]
  (while RUNNING
    (process-input socket)))

(defn create-socket[]
  (let [socket (s.socket s.AF_INET s.SOCK_STREAM)]
    (try
     (do
      (socket.bind (, HOST PORT))
      (socket.listen 1))
     (except [e s.error] ;;TODO expand error
       (print "Socket bind faild. Error: " e)))
    (print "socket binded to host" HOST "at port" PORT)
    socket))

(defn register[]
  (let [socket (create-socket)
        thread (apply (. th Thread) [] {:target thread-handle
                                        :args (, socket)})]
       (thread.start)))

(defn unregister[]
  (print "blispy repl unregistering"))

(defmain [&rest args]
  (register))
