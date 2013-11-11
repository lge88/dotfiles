

(global-set-key (kbd "<C-down-mouse-1>")
                (lambda (p)
                  (interactive "e")
                  (goto-char (nth 1 (nth 1 p)))
                  (find-file-at-point)))

(provide 'lge-mouse)
