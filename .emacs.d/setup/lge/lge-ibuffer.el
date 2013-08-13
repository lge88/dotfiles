
;; ibuffer settings:
(provide 'lge-ibuffer)
(require 'ibuffer)

(setq ibuffer-show-empty-filter-groups nil)
(setq ibuffer-expert t)
(add-hook 'ibuffer-mode-hook (lambda ()
                               (ibuffer-auto-mode 1)
                               ))
(ibuffer)
(ibuffer-switch-to-saved-filter-groups "documents")
;; Enable ibuffer-filter-by-filename to filter on directory names too.
(eval-after-load "ibuf-ext"
  '(define-ibuffer-filter filename
       "Toggle current view to buffers with file or directory name matching QUALIFIER."
     (:description "filename"
                   :reader (read-from-minibuffer "Filter by file/directory name (regexp): "))
     (ibuffer-awhen (or (buffer-local-value 'buffer-file-name buf)
                        (buffer-local-value 'dired-directory buf))
       (string-match qualifier it))))

(global-set-key (kbd  "C-x C-b") 'ibuffer)
