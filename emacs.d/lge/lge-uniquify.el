
(require 'uniquify)

(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator " • ")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

(provide 'lge-uniquify)
