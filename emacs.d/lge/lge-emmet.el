(require-package 'emmet-mode)
(require 'emmet-mode)

(let ((hooks
       (list
        'web-mode-hook
        'sgml-model-hook
        'css-mode-hook
        )))
  (mapc
   (lambda (m)
     (add-hook m 'emmet-mode)
     (add-hook m (lambda () yas-minor-mode 0))
     ) hooks))

;; Need to add to the emmet source code manually
;; ~/.emacs.d/elpa/emmet-mode-201xxxxx.xxxx/emmet-mode.el:931
;; (puthash "ff:h" "font-family:\"Helvetica Neue\", Helvetica, Arial, sans-serif;" tbl)

(provide 'lge-emmet)
