(require-package 'linum)
(require 'linum)

(add-hook 'prog-mode-hook (lambda () (linum-mode 1)))

(provide 'lge-linum)
