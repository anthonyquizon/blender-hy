(import [threading :as th]
        [socket :as s]
        [sys]
        [hy]
        [atexit]
        [signal])

(def HOST "localhost")
(def PORT 9992)
(def ENCODING "utf-8")
(def BUFFER_SIZE 4096)
(def RUNNING true)
(def ADDON_NAME "blispy")
(def thread nil)

(defn log [&rest args]
  (print ADDON_NAME ":" args))

(defclass StdOut[object]
  (defn __init__[self]
    (setv self.buffer ""))
  
  (defn write[self string]
    (let [out sys.__stdout__]
      (setv self.buffer (+ self.buffer string))
      (out.write string)))
  
  (defn flush[self]
    (setv self.buffer "")))

(defn send [conn data]
  (conn.send (data.encode ENCODING)))

(defn process-input [socket stdout]
  (let [[conn addr] (socket.accept)
        data (conn.recv BUFFER_SIZE)
        data-str (data.decode "utf-8")]
    (try
     (let [result (eval (read-str data-str) (globals))
           buffer (+ stdout.buffer (str result))]
       (send conn buffer)
       (stdout.flush))
     (except []
       (send conn "eval error")))))
  
(defn thread-handle []
  (let [socket (create-socket)
        stdout (StdOut)]
    (setv sys.stdout stdout)
    (while RUNNING
      ;;TODO threading events
      (process-input socket stdout))))

(defn create-socket[]
  (let [socket (s.socket s.AF_INET s.SOCK_STREAM)]
    (try
     (do
      (socket.bind (, HOST PORT))
      (socket.listen 1))
     (except [e s.error] ;;TODO expand error
       (log "Socket bind faild. Error:" e)))
    (log "socket binded to host" HOST "at port" PORT)
    socket))

(defn init[]
  (log "starting repl server")
  (setv thread (apply (. th Thread) [] {:target thread-handle}))
  (thread.start))

(defn stop[]
  (log "stopping repl server")
  ;; TODO stop threads
  )

(defn signal_handler[signal frame]
  (log "exiting")
  (sys.exit 0))

(defn on-register[]
  (init))

(defn on-unregister[])

(defn on-exit[]
  (stop))

(signal.signal signal.SIGINT signal-handler)

(atexit.register on-exit)

(defmain [&rest args]
  (init))
