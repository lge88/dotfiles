
;;; Includes keyboard bindings and short aliases

(require 'simple)
(require 'electric)
(global-set-key (kbd "C-j") 'newline)
(global-set-key (kbd "RET") 'electric-newline-and-maybe-indent)
(global-set-key (kbd "M-<right>") 'forward-word)
(global-set-key (kbd "M-<left>") 'backward-word)

(global-set-key (kbd "<f5>") 'toggle-truncate-lines)
(global-set-key (kbd "C-z") 'undo)

(require 'lge-auto-complete)
(define-key ac-mode-map (kbd "S-SPC") 'auto-complete)
(define-key ac-completing-map (kbd "<escape> <tab>") 'ac-stop)
(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)

(require 'ffap)
(global-set-key (kbd "C-c f") 'find-file-at-point)
(global-set-key (kbd "C-c C-f") 'find-file-at-point)

(require 'lge-files)
(global-set-key (kbd "C-x C-f") 'lge-find-file-from-scratch)

(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(require 'lge-helm)
(global-set-key (kbd "C-c h s") 'lge-helm-search-web)
(global-set-key (kbd "C-h f") 'lge-helm-describe-function)
(global-set-key (kbd "C-h v") 'lge-helm-describe-variable)

(require 'helm)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x f") 'helm-find-files)
(global-set-key (kbd "C-h a") 'helm-apropos)
(global-set-key (kbd "C-x C-i") 'helm-imenu)
(global-set-key (kbd "M-s o") 'helm-occur)

(global-set-key (kbd "C-c h r") 'helm-regexp)
(global-set-key (kbd "C-c h g") 'helm-do-grep)
(global-set-key (kbd "C-c h c") 'helm-colors)
(global-set-key (kbd "C-c h b") 'helm-bookmarks)
(global-set-key (kbd "C-c h m") 'helm-mark-ring)
(global-set-key (kbd "C-c h y") 'helm-show-kill-ring)

(require 'lge-lined)
(global-set-key (kbd "C-k") 'kill-line)
(global-set-key (kbd "M-r") 'toggle-comment-line-or-region)
(global-set-key (kbd "C-M-<down>") 'duplicate-line-or-region)
(global-set-key (kbd "C-M-<up>") 'duplicate-line-or-region)
(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)
(global-set-key (kbd "C-l") 'expand-region-as-lines)

(require 'undo-tree)
(define-key undo-tree-map (kbd "C-x u") nil)
(define-key undo-tree-map (kbd "C-/") nil)
(define-key undo-tree-map (kbd "C-c u") 'undo-tree-visualize)
(define-key undo-tree-map [remap undo] 'nil)

(require 'lge-edit)
;; (global-set-key (kbd "C-x C-i") 'ido-imenu)

(require-package 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(require-package 'multiple-cursors)
(require 'multiple-cursors)
(global-set-key (kbd "C-,") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-.") 'mc/mark-next-like-this)

(require 'lge-linum)
(global-set-key (kbd "<f6>") 'linum-mode)

(require 'lge-system-utils)
(global-set-key (kbd "<f8>") 'lge-open-terminal-here)
(global-set-key (kbd "<f9>") 'lge-open-file-brower-here)
(defalias 'cp 'lge-copy-marked-files-to-clipboard-in-dired)
(defalias 'paste 'lge-paste-files-in-pwd)

(require 'lge-scratch)
(global-set-key (kbd "C-c C-s") 'lge-switch-to-scratch-buffer)
(defalias 'tmp 'lge-create-tmp-here)
(defalias 'td 'lge-goto-today-folder)

(require 'lge-org)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)

(require 'lge-google-translate)
(global-set-key (kbd "C-c t") 'google-translate-at-point)
(global-set-key (kbd "C-c T") 'google-translate-query-translate)
(global-set-key (kbd "C-c r") 'google-translate-at-point-reverse)
(global-set-key (kbd "C-c R") 'google-translate-query-translate-reverse)

(require 'lge-white-board)
(defalias 'wb 'lge-enter-white-board-mode)
(defalias 'wbclear 'lge-exit-white-board-mode)

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
(define-key js-mode-map (kbd "<f12>") 'lge-js-toggle-js2-js-mode)
(define-key js2-mode-map (kbd "<f12>") 'lge-js-toggle-js2-js-mode)
(define-key js2-mode-map (kbd "C-c C-m t t") 'lge-js-time-this-region)
(define-key js-mode-map (kbd "C-c C-m t t") 'lge-js-time-this-region)
(define-key js-mode-map (kbd "C-c C-m i o") 'lge-js-insert-outline-for-buffer)
(define-key js2-mode-map (kbd "C-c C-m i o") 'lge-js-insert-outline-for-buffer)
(define-key js-mode-map (kbd "<f10>") 'lge-eval-node-js-on-region-or-buffer)
(define-key js2-mode-map (kbd "<f10>") 'lge-eval-node-js-on-region-or-buffer)
(define-key js2-mode-map (kbd "<f11>") 'lge-eval-node-js-on-region-and-replace)
(define-key js2-mode-map (kbd "<f11>") 'lge-eval-node-js-on-region-and-replace)

(require-package 'flycheck)
(require 'flycheck)
(define-key c++-mode-map (kbd "<f12>") 'flycheck-mode)
(define-key c-mode-map (kbd "<f12>") 'flycheck-mode)

(require 'lge-windows)
(global-set-key (kbd "C-x u") 'winner-undo)
(global-set-key (kbd "C-x U") 'winner-redo)
(global-set-key (kbd "C-x w v") `window-horizontal-to-vertical)
(global-set-key (kbd "C-x w h") `window-vertical-to-horizontal)

(require 'cua-base)
(global-set-key (kbd "<f7>") 'cua-mode)

(provide 'lge-bindings)
