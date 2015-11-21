
;; connect to repl PORT
;; TODO port arguments

;; (def PORT 9999)
;; (import [hy.completion :as completion]
;;         [hy.cmdline :as cmdline])

;; ;;create socket

(import [socket :as s]
        [version]
        [code])

(def HOST "localhost")
(def ENCODING "utf-8")
(def PORT 9999)

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
    socket
    ))

(defclass BlispyREPL[code.InteractiveConsole]
  
  (defn __init__ [self socket]
    (setv self.socket socket)
    (socket.connect (, HOST PORT) )
    (code.InteractiveConsole.__init__ self))
  
  (defn runsource[self source &optional [filename "<input>"] [symbol "single"]]
    (let [socket self.socket
          ;; [conn addr] (socket.accept)
          ]
      (socket.send (source.encode ENCODING))

      ;;TODO listen
      ;; false
    )))

(def socket (create-socket))
(def repl (BlispyREPL socket))

(repl.interact)
;; (print repl)

;;TODO main
