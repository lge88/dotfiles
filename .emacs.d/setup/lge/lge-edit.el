
(provide 'lge-edit)

(setq-default blink-cursor-delay 0)
(setq-default blink-cursor-interval 0.4)
(setq-default bookmark-default-file (expand-file-name "bookmarks.el" "~/.emacs.d/lge/"))
(setq-default buffers-menu-max-size 30)
(setq-default case-fold-search t)
(setq-default column-number-mode t)
(setq-default compilation-scroll-output t)
(setq-default delete-selection-mode t)
(setq-default ediff-split-window-function 'split-window-horizontally)
(setq-default ediff-window-setup-function 'ediff-setup-windows-plain)
(setq-default grep-highlight-matches t)
(setq-default grep-scroll-output t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default c-default-style "k&r")
(setq-default c-basic-offset 2)
(setq-default mouse-yank-at-point t)
(setq-default save-interprogram-paste-before-kill t)
(setq-default scroll-preserve-screen-position 'always)
(setq-default set-mark-command-repeat-pop t)
(setq-default show-trailing-whitespace t)
(setq-default tooltip-delay 1.5)
(setq-default truncate-partial-width-windows nil)
(setq-default auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
(setq-default backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
(setq-default visible-bell t)
(setq-default truncate-lines nil)
(setq-default make-backup-files t)
;; (setq-default line-spacing 0.2)

(delete-selection-mode 1)
(transient-mark-mode t)

(defun ido-imenu ()
  "Update the imenu index and then use ido to select a symbol to navigate to.
Symbols matching the text at point are put first in the completion list."
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
                       (when (listp symbol-list)
                         (dolist (symbol symbol-list)
                           (let ((name nil) (position nil))
                             (cond
                              ((and (listp symbol) (imenu--subalist-p symbol))
                               (addsymbols symbol))

                              ((listp symbol)
                               (setq name (car symbol))
                               (setq position (cdr symbol)))

                              ((stringp symbol)
                               (setq name symbol)
                               (setq position (get-text-property 1 'org-imenu-marker symbol))))

                             (unless (or (null position) (null name))
                               (add-to-list 'symbol-names name)
                               (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    ;; If there are matching symbols at point, put them at the beginning of `symbol-names'.
    (let ((symbol-at-point (thing-at-point 'symbol)))
      (when symbol-at-point
        (let* ((regexp (concat (regexp-quote symbol-at-point) "$"))
               (matching-symbols (delq nil (mapcar (lambda (symbol)
                                                     (if (string-match regexp symbol) symbol))
                                                   symbol-names))))
          (when matching-symbols
            (sort matching-symbols (lambda (a b) (> (length a) (length b))))
            (mapc (lambda (symbol) (setq symbol-names (cons symbol (delete symbol symbol-names))))
                  matching-symbols)))))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (goto-char position))))

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

(require-package 'mic-paren)
(paren-activate)

;; (require-package 'iy-go-to-char)
;; (require 'iy-go-to-char)
;; (global-set-key (kbd "M-m") 'iy-go-to-char)
;; (global-set-key (kbd "M-M") 'iy-go-to-char-backward)
;; (global-unset-key [C-down-mouse-1])
