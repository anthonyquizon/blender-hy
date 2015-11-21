;; connect to repl PORT
;; TODO port arguments

(import [socket :as s]
        [version]
        [code])

(def HOST "localhost")
(def ENCODING "utf-8")
(def BUFFER_SIZE 4096)
(def PORT 9993)

(defn socket-handle[socket data]
  (socket.connect (, HOST PORT) )
  (socket.send (data.encode ENCODING))
  (let [data (socket.recv BUFFER_SIZE)]
    (print (data.decode ENCODING)))
  (socket.close))

(defclass BlispyREPL[code.InteractiveConsole]
  (defn __init__ [self]
    (code.InteractiveConsole.__init__ self))
  
  (defn runsource[self source &optional [filename "<input>"] [symbol "single"]]
    (let [socket (s.socket s.AF_INET s.SOCK_STREAM)]
      (socket-handle socket source))))

(defn run-repl[]
  (let [repl (BlispyREPL)]
    (repl.interact)))

(defmain [&rest args]
  (run-repl))
