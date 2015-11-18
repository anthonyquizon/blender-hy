#!/usr/bin/env hy

;;TODO create zip

;;TODO watch
;; copy files on file change
;; TODO merge modules folder

;; TODO copy modules to modules folder
;; TODO remove old blisp folder and filename
  
(import shutil)
(import os)

(def dest-dir "/Users/anthony/Library/Application Support/Blender/2.76/scripts/addons/blisp")
(def src-dir (os.path.abspath "./blisp"))

(defn clean []
  (if (or (os.path.isdir dest-dir) (os.path.lexists dest-dir))
    (do (print "removing " dest-dir)
        (os.remove dest-dir))))

(defn copy-addon []
  (clean)
  (print "copying blisp to " dest-dir)
  (shutil.copytree src-dir dest-dir))

(defn syslink-addon[]
  (clean)
  (print "sys linking to " dest-dir)
  (os.symlink src-dir dest-dir))

;; (syslink-addon)
