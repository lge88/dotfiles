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
