
(setq inferior-lisp-program
      "~/Develop/clojure/clojurescript/script/repl"
      inferior-lisp-load-command "(load \"%s\")\n"
      lisp-function-doc-command "(doc %s)\n"
      lisp-var-doc-command "(doc %s)\n")

(provide 'lge-clojure)
