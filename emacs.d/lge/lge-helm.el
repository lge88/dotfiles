
(require-package 'helm)
(require 'helm)

(setq helm-truncate-lines t)
(setq helm-buffers-favorite-modes
      '(text-mode
        js2-mode
        emacs-lisp-mode
        python-mode
        markdown-mode
        ))

(require 'helm-net)
(defun lge-helm-search-web ()
  (interactive)
  (helm :sources '(helm-source-google-suggest
                   helm-source-wikipedia-suggest
                   )
        :buffer "*helm web search*"
        :truncate-lines t))

(require 'helm-elisp)
(defun lge-helm-describe-function ()
     (interactive)
     (let (funs cmds default)
       (setq default (thing-at-point 'symbol))
       (setq funs (helm-def-source--emacs-functions default))
       (setq cmds (helm-def-source--emacs-commands default))
       (helm :sources '(funs cmds)
             :buffer "*helm describe function*"
             :preselect (and default (concat "\\_<" (regexp-quote default) "\\_>"))
             :truncate-lines t)))

(defun lge-helm-describe-variable ()
     (interactive)
     (let (vars default)
       (setq default (thing-at-point 'symbol))
       (setq vars (helm-def-source--emacs-variables default))
       (helm :sources '(vars)
             :buffer "*helm describe variable*"
             :preselect (and default (concat "\\_<" (regexp-quote default) "\\_>"))
             :truncate-lines t)))

(provide 'lge-helm)
