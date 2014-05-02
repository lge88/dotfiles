
(global-set-key (kbd "<C-mouse-1>") 'ffap-at-mouse)

(global-set-key (kbd "<C-down-mouse-5>") 'lge-text-scale-increase-1)
(global-set-key (kbd "<C-down-mouse-4>") 'lge-text-scale-decrease-1)

;; mac
(global-set-key (kbd "<C-wheel-up>") 'lge-text-scale-increase-1)
(global-set-key (kbd "<C-wheel-down>") 'lge-text-scale-decrease-1)

(defun lge-text-scale-decrease-1 ()
  "DOCSTRING"
  (interactive)
  (text-scale-decrease 1))

(defun lge-text-scale-increase-1 ()
  "DOCSTRING"
  (interactive)
  (text-scale-increase 1))

(provide 'lge-mouse)
