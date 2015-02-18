
(require 'vc-git)
(require-package 'yasnippet)

(require 'yasnippet)

(defun lge-create-snippet-from-region (start end)
  "marked region copy to snippet creation buffer"
  (interactive "r")
  (kill-ring-save start end)
  (yas-new-snippet)
  (yas-exit-all-snippets)
  (yank))

;; (setq yas/root-directory "~/.emacs.d/snippets")

;; After package update:
;;   - Goto ~/.emacs.d/elpa/yasnippet-201xxxxx.xxx/snippets/js-mode/
;;   - Rename f -> _f, for -> _for to disable the snippet prompt.

;; (yas/reload-all)
(yas/global-mode 1)

(provide 'lge-yasnippet)
