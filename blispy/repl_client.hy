;; connect to repl PORT
;; TODO port arguments

(import [socket :as s]
        [version]
        [code]
        [hy.completer [completion Completer]]
        [hy.lex [LexException PrematureEndOfInput tokenize]])

(def HOST "localhost")
(def ENCODING "utf-8")
(def BUFFER_SIZE 4096)
(def PORT 9991)
(def banner (.format "{} {}" version.__appname__ version.__version__))

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
    (try
     (do
      (tokenize source)
      (let [socket (s.socket s.AF_INET s.SOCK_STREAM)]
        (socket-handle socket source)))
     (except [e PrematureEndOfInput]
       true)
     (except [e LexException]
       (do
        (if (= e.source None)
         (do
          (setv e.source source)
          (setv e.source source)))
        (sys.stderr.write (str e))
        false)))))

;; TODO fun blispy banner
(defn run-repl[]
  (let [repl (BlispyREPL)
        namespace {"__name__" "__console__" "__doc__" ""}]
    (repl.interact banner)

    ;;TODO completion from server side?
    ;; (with (completion (Completer namespace))
    ;;       (repl.interact "Hello BLISPY!"))
    ))

(defmain [&rest args]
  (run-repl))
