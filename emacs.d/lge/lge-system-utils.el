
(provide 'lge-system-utils)

(defun __filename () load-file-name)
(defun __dirname ()
  (file-name-as-directory load-file-name))

(defun pwd ()
  "Show the current default directory.
Copy the directory to clipboard."
  (interactive nil)
  (with-temp-buffer
    (insert (expand-file-name default-directory))
    (kill-ring-save (point-min) (point-max)))
  (message "Directory %s" default-directory))

(defconst *system-open*
  (cond
   ((eq system-type 'darwin)
    "open")
   ((eq system-type 'gnu/linux)
    "gnome-open")
   (t
    "gnome-open")))

(defconst *system-terminal*
  (cond
   ((eq system-type 'darwin)
    "open -a iTerm")
   ((eq system-type 'gnu/linux)
    "gnome-terminal")
   (t
    "gnome-terminal")))

(defun lge-open-terminal-here ()
  "open ternimal and go to current directory"
  (interactive)
  (shell-command (concat *system-terminal* " .") nil nil))

(defun lge-open-file-brower-here ()
  "open ternimal and go to current directory"
  (interactive)
  (shell-command (concat *system-open* " .") nil nil))

;; Copy and paste

(setq lge-file-clipboard nil)
(defun lge-copy-marked-files-to-clipboard-in-dired ()
  (interactive)
  (setq lge-file-clipboard (dired-get-marked-files)))

(defun lge-clear-file-clipboard ()
  (interactive)
  (setq lge-file-clipboard nil))

(defun lge-show-file-clipboard ()
  (interactive)
  (print lge-file-clipboard))

(defun lge-paste-files-in-pwd ()
  (interactive)
  (mapc
   (lambda (file)
     (dired-copy-file-recursive file default-directory nil nil nil 'always))
   lge-file-clipboard)
  (revert-buffer))
