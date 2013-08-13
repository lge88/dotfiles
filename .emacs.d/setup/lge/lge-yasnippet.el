(provide 'lge-yasnippet)

(require 'vc-git)
(require-package 'yasnippet)

(require 'yasnippet)
(yas--initialize)

;; (setq yas/root-directory "~/.emacs.d/snippets")

;; (yas/reload-all)
(yas/global-mode 1)
