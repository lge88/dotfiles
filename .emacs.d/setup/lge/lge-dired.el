(provide 'lge-dired)

(require-package 'dired+)

(setq diredp-hide-details-initially-flag nil)
(setq global-dired-hide-details-mode -1)

(setq dired-listing-switches "-alh")
(setq dired-auto-revert-buffer t)
(setq wdired-allow-to-change-permissions t)

(after-load
 'dired
 (require 'ido)
 (require 'dired+)
 (setq dired-recursive-deletes 'top)
 ;; (define-key dired-mode-map [mouse-1] 'dired-find-file)
 ;; (define-key dired-mode-map [mouse-2] 'dired-find-file-other-window)
 (define-key dired-mode-map (kbd "j") 'ido-find-file))

(require 'find-dired)
(defalias 'rfind 'find-name-dired)

(eval-after-load "dired-aux"
  '(add-to-list 'dired-compress-file-suffixes
                '("\\.zip\\'" ".zip" "unzip")))

(defun lge-ls ()
  "list current directory in dired"
  (interactive)
  (dired default-directory))

(defun lge-ls-other-window ()
  "list current directory in dired"
  (interactive)
  (dired-other-window default-directory))

(defalias 'ls 'lge-ls)
(defalias 'lso 'lge-ls-other-window)

(require 'dired)
(require-package 'dash)
(require 'dash)

;; Make dired less verbose
(require-package 'dired-details)
(require 'dired-details)
(setq-default dired-details-hidden-string "--- ")
(dired-details-install)

;; Move files between split panes
(setq dired-dwim-target t)

;; Reload dired after making changes
(--each '(dired-do-rename
          dired-do-copy
          dired-create-directory
          wdired-abort-changes)
        (eval `(defadvice ,it (after revert-buffer activate)
                 (revert-buffer))))

;; C-a is nicer in dired if it moves back to start of files
(defun dired-back-to-start-of-files ()
  (interactive)
  (backward-char (- (current-column) 2)))

(define-key dired-mode-map (kbd "C-a") 'dired-back-to-start-of-files)
(define-key dired-mode-map (kbd "k") 'dired-do-delete)

;; M-up is nicer in dired if it moves to the fourth line - the first file
(defun dired-back-to-top ()
  (interactive)
  (beginning-of-buffer)
  (dired-next-line 4))

(define-key dired-mode-map (vector 'remap 'beginning-of-buffer) 'dired-back-to-top)
(define-key dired-mode-map (vector 'remap 'smart-up) 'dired-back-to-top)

;; M-down is nicer in dired if it moves to the last file
(defun dired-jump-to-bottom ()
  (interactive)
  (end-of-buffer)
  (dired-next-line -1))

(define-key dired-mode-map (vector 'remap 'end-of-buffer) 'dired-jump-to-bottom)
(define-key dired-mode-map (vector 'remap 'smart-down) 'dired-jump-to-bottom)

;; Delete with C-x C-k to match file buffers and magit
(define-key dired-mode-map (kbd "C-x C-k") 'dired-do-delete)

(eval-after-load "wdired"
  '(progn
     (define-key wdired-mode-map (kbd "C-a") 'dired-back-to-start-of-files)
     (define-key wdired-mode-map (vector 'remap 'beginning-of-buffer) 'dired-back-to-top)
     (define-key wdired-mode-map (vector 'remap 'end-of-buffer) 'dired-jump-to-bottom)))
