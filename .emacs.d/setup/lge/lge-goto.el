(defun lge-goto-cci-folder ()
  "Goto cci folder"
  (interactive)
  (dired "~/Dropbox/cci/"))

(provide 'lge-goto)

(defalias 'cci 'lge-goto-cci-folder)
