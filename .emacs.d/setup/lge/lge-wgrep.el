(require-package 'wgrep)

(require 'wgrep)
(define-key grep-mode-map (kbd "C-x C-q") 'wgrep-change-to-wgrep-mode)

(provide 'lge-wgrep)
