(require-package 'paredit)
(require 'paredit)

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
