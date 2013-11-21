
(require-package 'scratch)

(defun lge-shell-command-result (str)
  "Trim the ending return character"
  (let (f)
    (setq f (shell-command-to-string str))
    (substring f 0 (- (length f) 1))))

(defvar lge-tmp-folder (file-name-as-directory (expand-file-name "~/Dropbox/tmp")))

(defun lge-create-tmp-here ()
  "Create a tmp buffer here"
  (interactive)
  (let (now the-mode)
    (setq the-mode major-mode)
    (setq now
          (concat "*" (substring (symbol-name the-mode) 0 -5) "-"
                  (format-time-string "%Y-%m-%d-%H-%M-%S") "*"))
    (switch-to-buffer (get-buffer-create now))
    (funcall (symbol-function the-mode))))

(defun lge-goto-today-folder ()
  "Jump to today's folder"
  (interactive)
  (let ((folder (file-name-as-directory (concat lge-tmp-folder "/" (format-time-string "%Y%m%d")))))
    (make-directory folder t)
    (dired folder)))

(defun lge-switch-to-scratch-buffer (&optional arg)
  "Preserve the current directory"
  (interactive "p")
  (let ((dir default-directory) )
    (scratch arg)
    (setq default-directory dir)))


(provide 'lge-scratch)
