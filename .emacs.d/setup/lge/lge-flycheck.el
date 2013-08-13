
(when (eval-when-compile (>= emacs-major-version 24))
  (require-package 'flycheck)
  (global-set-key (kbd "M-<f12>") 'flycheck-mode))

(provide 'lge-flycheck)
