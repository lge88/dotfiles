(defun lge-goto-cci-folder ()
  "Goto cci folder"
  (interactive)
  (dired "~/Dropbox/cci/"))

(defun lge-goto-cs-folder ()
  "Goto cci folder"
  (interactive)
  (dired "~/Dropbox/cs"))

(provide 'lge-goto)

(defalias 'cci 'lge-goto-cci-folder)
