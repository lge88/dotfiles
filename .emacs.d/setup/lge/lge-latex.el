
(require 'tex-mode)
(require 'reftex)
(add-hook 'tex-mode-hook (lambda () "DOCSTRING" (interactive)
                           (auto-fill-mode)))

(provide 'lge-latex)
