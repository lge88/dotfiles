
(require 'vc-git)
(require-package 'yasnippet)

(require 'yasnippet)
(yas--initialize)

(defun lge-create-snippet-from-region (start end)
  "marked region copy to snippet creation buffer"
  (interactive "r")
  (kill-ring-save start end)
  (yas-new-snippet)
  (yas-exit-all-snippets)
  (yank))

;; (setq yas/root-directory "~/.emacs.d/snippets")

;; (yas/reload-all)
(yas/global-mode 1)
;; (yas/global-mode nil)

(provide 'lge-yasnippet)
