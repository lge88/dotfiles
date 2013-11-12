
(global-set-key (kbd "<C-mouse-1>") 'ffap-at-mouse)

(global-set-key (kbd "<C-down-mouse-5>")
                (lambda ()
                  (interactive)
                  (text-scale-decrease 1)))

(global-set-key (kbd "<C-down-mouse-4>")
                (lambda ()
                  (interactive)
                  (text-scale-increase 1)))

(provide 'lge-mouse)
