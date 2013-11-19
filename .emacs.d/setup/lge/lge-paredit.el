(require-package 'paredit)
(require 'paredit)

(mapc
 (lambda (hk)
   (add-hook hk (lambda () (paredit-mode 1))))
 '(emacs-lisp-mode-hook lisp-interaction-mode-hook))

;;; TODO: want C-j be eval print in interaction mode
;; (add-hook 'lisp-interaction-mode-hook
;;           (lambda () (define-key paredit-mode-map (kbd "C-j") nil)))


(defun lge-wrap-region-1 (start end)
  "wrap active region with parenc ()"
  (interactive "r")
  (goto-char end)
  (insert ")")
  (goto-char start)
  (insert "(")
  (backward-char))

(defun lge-wrap-region-2 (start end)
  "wrap active region with parenc {}"
  (interactive "r")
  (goto-char end)
  (insert "}")
  (goto-char start)
  (insert "{")
  (backward-char))

(defun lge-wrap-region-3 (start end)
  "wrap active region with parenc []"
  (interactive "r")
  (goto-char end)
  (insert "]")
  (goto-char start)
  (insert "[")
  (backward-char))

(provide 'lge-paredit)
