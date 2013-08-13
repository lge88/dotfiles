
(defun my-bell-function ()
  (unless (memq this-command
    	'(mwheel-scroll down up next-line previous-line
              backward-char forward-char))
    (ding)))
(setq ring-bell-function 'my-bell-function)

(setq visible-bell t)
(setq-default truncate-lines t)
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(global-font-lock-mode 1)
(global-hl-line-mode 0)
(transient-mark-mode 1)
(column-number-mode 1)
;; (setq shell-command-switch "-ic")

(global-auto-revert-mode 1)
(setq next-screen-context-lines 10)
(menu-bar-mode 1)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq x-select-enable-clipboard t)
(setq frame-title-format '("" "%b @ Emacs " emacs-version))
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))
(fset 'yes-or-no-p 'y-or-n-p)

(setq dired-dwim-target nil)
(setq ibuffer-saved-filter-groups (quote (("direcotories" ("directories" (saved . "directories")) ("documents" (saved . "documents")) ("directories" (saved . "directories"))) ("documents" ("documents" (saved . "documents"))))))
(setq ibuffer-saved-filters (quote (("sketchit-lite" ((filename . "^/home/GL/Dropbox/projects/websites/sketchit-lite.*"))) ("directories" ((mode . dired-mode))) ("documents" ((not mode . dired-mode) (name . "^[^\\*]"))) ("gnus" ((or (mode . message-mode) (mode . mail-mode) (mode . gnus-group-mode) (mode . gnus-summary-mode) (mode . gnus-article-mode)))) ("programming" ((or (mode . emacs-lisp-mode) (mode . cperl-mode) (mode . c-mode) (mode . java-mode) (mode . idl-mode) (mode . lisp-mode)))))))
(setq markdown-command "marked --gfm")
(setq vc-follow-symlinks nil)

;; file associations:
(setq auto-mode-alist (cons '(".*bashrc.*" . sh-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".*bash_.*" . sh-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".*emacs_bash.*" . sh-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".*emacs\\.bmk.*" . emacs-lisp-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("Makefile\\.def" . makefile-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("CMakeLists\\.txt\\'" . cmake-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cmake\\'" . cmake-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
(add-to-list 'auto-mode-alist '("\\.ops$" . tcl-mode))
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

(provide 'lge-custom)
;;; lge-custom.el ends here
