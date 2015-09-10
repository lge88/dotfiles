(eval-after-load "files"
  '(progn
     (global-set-key (kbd "C-x s") 'save-buffer)))

(defun lge-find-file-from-scratch ()
  (interactive)
  (find-file (read-file-name "Path: " "~/" "~/" nil "" nil)))

(provide 'lge-files)
