(require-package 'paredit)
(require 'paredit)

(mapc
 (lambda (hk)
   (add-hook hk (lambda () (paredit-mode 1))))
 '(emacs-lisp-mode-hook lisp-interaction-mode-hook))

;;; TODO: want C-j be eval print in interaction mode
;; (add-hook 'lisp-interaction-mode-hook
;;           (lambda () (define-key paredit-mode-map (kbd "C-j") nil)))

(provide 'lge-paredit)
