
(provide 'lge-tmp)

(require-package 'scratch)
(global-set-key (kbd "C-c C-s") 'scratch)

(defun lge-shell-command-result (str)
  "Trim the ending return character"
  (let (f)
    (setq f (shell-command-to-string str))
    (substring f 0 (- (length f) 1))
    ))

(defun lge-create-tmp-here ()
  "Create a tmp buffer here"
  (interactive)
  (let (now the-mode)
    (setq the-mode (symbol-name major-mode))
    (setq now (lge-shell-command-result (concat "date +*" the-mode "-%y-%b-%d-%H-%M-%S*")))
    (switch-to-buffer (get-buffer-create now))))
    ;; ((symbol-function (make-symbol the-mode)) 1)))
(defalias 'tmp 'lge-create-tmp-here)

(defun lge-goto-today-folder ()
  "Jump to today's folder"
  (interactive)
  (let (f)
    (setq f (shell-command-to-string
             "mkdir -p ~/Dropbox/tmp/`date +%Y%m%d` && cd ~/Dropbox/tmp/`date +%Y%m%d` && pwd"))
    (dired (substring f 0 (- (length f) 1)))
    ))
(defalias 'td 'lge-goto-today-folder)
