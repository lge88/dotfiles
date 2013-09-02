
(provide 'lge-autopair)
(require 'vc-git)
(require-package 'autopair)

(require 'autopair)
(autopair-global-mode 1)

(add-hook 'emacs-lisp-mode-hook (lambda () (autopair-mode 0 )))
