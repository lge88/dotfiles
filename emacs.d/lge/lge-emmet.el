(require-package 'emmet-mode)
(require 'emmet-mode)

(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)
(add-hook 'sgml-mode-hook (lambda ()
                            (yas-minor-mode 0)))
(add-hook 'css-mode-hook (lambda ()
                            (yas-minor-mode 0)))

(provide 'lge-emmet)
