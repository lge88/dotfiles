
(eval-after-load "files"
  '(progn
     (global-set-key (kbd "C-x s") 'save-buffer)))

(defun lge-find-file-from-scratch (arg)
  (interactive "sPath: ")
  (find-file arg))

(provide 'lge-files)
