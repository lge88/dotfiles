(require 'simple)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "M-<right>") 'forward-word)
(global-set-key (kbd "M-<left>") 'backward-word)

(global-set-key (kbd "<f5>") 'toggle-truncate-lines)
(global-set-key (kbd "C-z") 'undo)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)

(require 'lge-ido)
(global-set-key (kbd "C-x f") 'ido-find-file)

(require 'ffap)
(global-set-key (kbd "C-c f") 'find-file-at-point)

(require 're-builder)
(global-set-key (kbd "C-c r") 're-builder)
(define-key reb-mode-map (kbd "C-c q") 'reb-quit)

(require 'lge-lined)
(global-set-key (kbd "C-k") 'kill-line)
(global-set-key (kbd "M-r") 'toggle-comment-line-or-region)
(global-set-key (kbd "C-M-<down>") 'duplicate-line-or-region)
(global-set-key (kbd "C-M-<up>") 'duplicate-line-or-region)
(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)
(global-set-key (kbd "C-l") 'expand-region-as-lines)

(require 'lge-undo-tree)
(define-key undo-tree-map (kbd "C-x u") nil)
(define-key undo-tree-map (kbd "C-/") nil)
(define-key undo-tree-map (kbd "C-c u") 'undo-tree-visualize)
(define-key undo-tree-map [remap undo] 'nil)

(require 'lge-edit)
(global-set-key (kbd "C-x C-i") 'ido-imenu)
(global-set-key [remap move-beginning-of-line] 'smarter-move-beginning-of-line)

(require-package 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(require-package 'multiple-cursors)
(require 'multiple-cursors)
(global-set-key (kbd "C-,") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-.") 'mc/mark-next-like-this)

(require 'lge-nlinum)
(global-set-key (kbd "<f6>") 'nlinum-mode)

(require 'lge-system-utils)
(global-set-key (kbd "<f8>") 'lge-open-terminal-here)
(global-set-key (kbd "<f9>") 'lge-open-file-brower-here)
(defalias 'cp 'lge-copy-marked-files-to-clipboard-in-dired)
(defalias 'paste 'lge-paste-files-in-pwd)

(require 'lge-scratch)
(global-set-key (kbd "C-c s") 'scratch)
(defalias 'tmp 'lge-create-tmp-here)
(defalias 'td 'lge-goto-today-folder)

(require 'lge-org)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)

(require 'lge-wgrep)
(define-key grep-mode-map (kbd "C-x C-q") 'wgrep-change-to-wgrep-mode)

(require 'lge-hippie-expand)
(global-set-key (kbd "M-/") 'hippie-expand)

(require 'lge-paredit)
(define-key lisp-mode-shared-map (kbd "<f12>") 'paredit-mode)

(require 'lge-yasnippet)
(global-set-key (kbd "C-c y") 'lge-create-snippet-from-region)

(require 'lge-js)
(require 'lge-paredit)
(define-key js-mode-map (kbd "<f12>") 'lge-toggle-js2-js-mode)
(define-key js2-mode-map (kbd "<f12>") 'lge-toggle-js2-js-mode)
(define-key js-mode-map (kbd "M-(") 'lge-wrap-region-1)
(define-key js2-mode-map (kbd "M-(") 'lge-wrap-region-1)
(define-key js2-mode-map (kbd "C-c t") 'lge-console-time-region)
(define-key js-mode-map (kbd "C-c t") 'lge-console-time-region)

(provide 'lge-bindings)
