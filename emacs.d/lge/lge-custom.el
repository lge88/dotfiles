;; file associations:
(add-to-list 'auto-mode-alist '(".*bashrc.*" . sh-mode))
(add-to-list 'auto-mode-alist '(".*bash_.*" . sh-mode))
(add-to-list 'auto-mode-alist '(".*emacs_bash.*" . sh-mode))
(add-to-list 'auto-mode-alist '(".*emacs\\.bmk.*" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("Makefile\\.def" . makefile-mode))
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
(add-to-list 'auto-mode-alist '("\\.ops$" . tcl-mode))
(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

(put 'downcase-region 'disabled nil)
(put 'narrow-to-defun 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)

(setq dired-dwim-target nil)
(setq frame-title-format '("" "%b @ Emacs " emacs-version))
(setq ibuffer-saved-filter-groups (quote (("direcotories" ("directories" (saved . "directories")) ("documents" (saved . "documents")) ("directories" (saved . "directories"))) ("documents" ("documents" (saved . "documents"))))))
(setq ibuffer-saved-filters (quote (("sketchit-lite" ((filename . "^/home/GL/Dropbox/projects/websites/sketchit-lite.*"))) ("directories" ((mode . dired-mode))) ("documents" ((not mode . dired-mode) (name . "^[^\\*]"))) ("gnus" ((or (mode . message-mode) (mode . mail-mode) (mode . gnus-group-mode) (mode . gnus-summary-mode) (mode . gnus-article-mode)))) ("programming" ((or (mode . emacs-lisp-mode) (mode . cperl-mode) (mode . c-mode) (mode . java-mode) (mode . idl-mode) (mode . lisp-mode)))))))
(setq inhibit-startup-message t)
;; (setq initial-scratch-message "")
(setq markdown-command "marked --gfm")
(setq next-screen-context-lines 10)
(setq ring-bell-function 'my-bell-function)
(setq vc-follow-symlinks nil)
(setq visible-bell t)
(setq x-select-enable-clipboard t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default truncate-lines t)
(setq indent-line-function 'insert-tab)
(set-fontset-font t 'han (font-spec :name "Songti SC"))
(setq cursor-type 'bar)
;; (setq shell-command-switch "-ic")

;;; This solves the problem:
;;; quit: "pasteboard doesn't contain valid data"
(setq save-interprogram-paste-before-kill nil)

(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))
(column-number-mode 1)
(global-auto-revert-mode 1)
(global-font-lock-mode 1)
(global-hl-line-mode 0)
(menu-bar-mode 1)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(transient-mark-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)

(defun my-bell-function ()
  (unless (memq this-command
    	'(mwheel-scroll down up next-line previous-line
              backward-char forward-char))
    (ding)))

(provide 'lge-custom)
;;; lge-custom.el ends here
