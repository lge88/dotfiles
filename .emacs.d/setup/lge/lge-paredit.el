(require-package 'paredit)
(require 'paredit)

(mapc
 (lambda (hk)
   (add-hook hk (lambda () (paredit-mode 1))))
 '(emacs-lisp-mode-hook lisp-interaction-mode-hook))

(provide 'lge-paredit)
