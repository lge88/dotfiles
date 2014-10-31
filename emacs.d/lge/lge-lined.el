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
    (execute-kbd-macro [?\C-a ?\C-@ ?\C-e ?\M-\;])))

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
         (execute-kbd-macro (kbd "C-w"))))
    (execute-kbd-macro (kbd "C-S-<backspace>"))))

(defun duplicate-current-line-or-region ()
  (interactive)
  (if mark-active
      ((lambda ()
         (expand-region-as-lines)
         (if (>= (mark) (point))
             (exchange-point-and-mark))
         (execute-kbd-macro (kbd "M-w"))
         (newline)
         (yank)
         (execute-kbd-macro (kbd "C-x C-x C-x C-x"))))
    ((lambda ()
       (beginning-of-line)
       (kill-line)
       (yank)
       (newline)
       (yank)))))

(defun duplicate-line-or-region ()
  (interactive)
  (let
      ((pcol (current-column)))
    (if (region-active-p)
        (let ((m (mark))
              (p (point))
              beg
              end
              (mcol
               (let (col)
                 (exchange-point-and-mark)
                 (setq col (current-column))
                 (exchange-point-and-mark) col)))
          (if (> p m)
              (progn
                (end-of-line)
                (setq end (point))
                (exchange-point-and-mark)
                (beginning-of-line)
                (setq beg (point))
                (kill-ring-save beg end)
                (exchange-point-and-mark)
                (newline)
                (yank)
                (setq p (point))
                (exchange-point-and-mark)
                (move-to-column mcol)
                (push-mark)
                (goto-char p)
                (move-to-column pcol))
            (progn
              (beginning-of-line)
              (setq beg (point))
              (exchange-point-and-mark)
              (end-of-line)
              (setq end (point))
              (kill-ring-save beg end)
              (newline)
              (setq p (point))
              (yank)
              (move-to-column mcol)
              (push-mark)
              (goto-char p)
              (move-to-column pcol)))
          ;; this is the trick...
          (setq deactivate-mark nil))
      (progn
        (kill-ring-save (line-beginning-position) (line-end-position))
        (end-of-line)
        (newline)
        (yank)
        (move-to-column pcol)))))

(defun jump-to-newline ()
  (interactive)
  (execute-kbd-macro (kbd "C-e C-j")))

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
      (if (> arg 0)
          (progn
            (forward-line)
            (transpose-lines 1)
            (forward-line -1))
        (progn
          (transpose-lines 1)
          (forward-line -2)))
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

(provide 'lge-lined)
