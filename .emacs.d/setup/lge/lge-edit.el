
(provide 'lge-edit)
(require-package 'whole-line-or-region)

(setq-default
 blink-cursor-delay 0
 blink-cursor-interval 0.4
 bookmark-default-file (expand-file-name "bookmarks.el" "~/.emacs.d/lge/")
 buffers-menu-max-size 30
 case-fold-search t
 column-number-mode t
 compilation-scroll-output t
 delete-selection-mode t
 ediff-split-window-function 'split-window-horizontally
 ediff-window-setup-function 'ediff-setup-windows-plain
 grep-highlight-matches t
 grep-scroll-output t
 indent-tabs-mode nil
 line-spacing 0.2
 mouse-yank-at-point t
 save-interprogram-paste-before-kill t
 scroll-preserve-screen-position 'always
 set-mark-command-repeat-pop t
 show-trailing-whitespace t
 tooltip-delay 1.5
 ;; truncate-lines nil
 truncate-partial-width-windows nil
 ;; make-backup-files t
 auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t)))
 backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/")))
 visible-bell t)

(transient-mark-mode t)

(global-set-key (kbd "RET") 'newline-and-indent)

(require-package 'undo-tree)
(global-undo-tree-mode)
(diminish 'undo-tree-mode)
(require 'undo-tree)
(define-key undo-tree-map (kbd "C-x u") nil)
(define-key undo-tree-map (kbd "C-/") nil)
(define-key undo-tree-map (kbd "C-c u") 'undo-tree-visualize)

(require-package 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)

(global-unset-key [M-left])
(global-unset-key [M-right])

(require-package 'mic-paren)
(paren-activate)

(require-package 'ace-jump-mode)
(require 'ace-jump-mode)
(global-set-key (kbd "C-;") 'ace-jump-char-mode)
(global-set-key (kbd "C-M-;") 'ace-jump-word-mode)

(require-package 'multiple-cursors)
;; multiple-cursors
(global-set-key (kbd "C-,") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-.") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-+") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-.") 'mc/mark-all-like-this)
;; From active region to multiple cursors:
(global-set-key (kbd "C-c c r") 'set-rectangular-region-anchor)
(global-set-key (kbd "C-c c c") 'mc/edit-lines)
(global-set-key (kbd "C-c c e") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-c c a") 'mc/edit-beginnings-of-lines)

(global-set-key (kbd "C-c j") 'join-line)
(global-set-key (kbd "C-c J") (lambda () (interactive) (join-line 1)))

(require-package 'nlinum)
(require 'nlinum)
(global-set-key (kbd "<f6>") 'nlinum-mode)

(require 'lined)
(global-set-key (kbd "C-k") 'kill-line)
;; (global-set-key (kbd "C-S-d") 'kill-whole-line-or-region)
;; (global-set-key (kbd "<S-return>") 'jump-to-newline)
(global-set-key (kbd "M-r") 'toggle-comment-line-or-region)

;; (global-set-key (kbd "C-M-<down>") 'duplicate-current-line-or-region)
;; (global-set-key (kbd "C-M-<up>") 'duplicate-current-line-or-region)
;; (global-set-key (kbd "M-<up>") 'move-text-up)
;; (global-set-key (kbd "M-<down>") 'move-text-down)

(global-set-key (kbd "C-M-j") 'duplicate-current-line-or-region)
(global-set-key (kbd "C-M-p") 'move-text-up)
(global-set-key (kbd "C-M-n") 'move-text-down)

(global-set-key (kbd "C-l") 'expand-region-as-lines)

(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)
