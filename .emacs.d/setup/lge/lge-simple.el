(provide 'lge-simple)

(require 'simple)
(require 'undo-tree)
(global-set-key (kbd "<f5>") 'toggle-truncate-lines)
(define-key undo-tree-map [remap undo] 'nil)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-M-h") 'backward-kill-word)
