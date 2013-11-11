
(require 'tex-mode)
(require 'reftex)

(add-hook 'tex-mode-hook
          (lambda () (interactive) (auto-fill-mode)))

(provide 'lge-tex)
