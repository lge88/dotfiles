(require 'simple)
(defun toggle-comment-line-or-region ()
  "comment current line or selected region"
  (interactive)
  (if mark-active
      (let (beg end)
        (if (>= (point) (mark))
            (progn
              (setq beg (mark))
              (setq end (point)))
          (progn
            (setq beg (point))
            (setq end (mark))))
        (goto-char beg)
        (beginning-of-line)
        (execute-kbd-macro [?\C-@])
        (goto-char end)
        (end-of-line)
        (execute-kbd-macro [?\M-\;]))
    (execute-kbd-macro [?\M-m ?\C-@ ?\C-e ?\M-\;])))

(defun expand-region-as-lines ()
  (interactive)
  (if mark-active
      (let (beg end)
        (if (>= (point) (mark))
            (progn
              (setq beg (mark))
              (setq end (point)))
          (progn
            (setq beg (point))
            (setq end (mark))))
        (goto-char beg)
        (execute-kbd-macro [?\C-a ?\C-@])
        (goto-char end)
        (execute-kbd-macro [?\C-e]))
    (let (deactivate-mark)
      (execute-kbd-macro [?\C-e ?\C-@ ?\C-a]))))

(defun kill-whole-line-or-region ()
  (interactive)
  (if mark-active
      ((lambda ()
         (expand-region-as-lines)
         (execute-kbd-macro (key "C-w"))))
    (execute-kbd-macro (key "C-S-<backspace>"))))

(defun duplicate-current-line-or-region ()
  (interactive)
  (if mark-active
      ((lambda ()
         (expand-region-as-lines)
         (if (>= (mark) (point))
             (exchange-point-and-mark))
         (execute-kbd-macro (key "M-w"))
         (newline)
         (yank)
         (execute-kbd-macro (key "C-x C-x C-x C-x"))))
    ((lambda ()
       (beginning-of-line)
       (kill-line)
       (yank)
       (newline)
       (yank)))))

(defun jump-to-newline ()
  (interactive)
  (execute-kbd-macro (key "C-e C-j")))

(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (expand-region-as-lines)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((text (delete-and-extract-region (point) (mark))))
      (delete-char 1)
      (forward-line arg)
      (set-mark (point))
      (insert text)
      (newline)
      (previous-line)
      (end-of-line)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg))
        (forward-line -1))
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

(defun uniq-lines (beg end)
  "Unique lines in region.
Called from a program, there are two arguments:
BEG and END (region to sort)."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (not (eobp))
        (kill-line 1)
        (yank)
        (let ((next-line (point)))
          (while
              (re-search-forward
               (format "^%s" (regexp-quote (car kill-ring))) nil t)
            (replace-match "" nil nil))
          (goto-char next-line))))))

(provide 'lined)
