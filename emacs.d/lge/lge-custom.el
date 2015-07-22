;; file associations:
(add-auto-mode 'sh-mode ".*bashrc.*" ".*bash_.*" ".*emacs_bash.*")
(add-auto-mode 'emacs-lisp-mode ".*emacs\\.bmk.*")
(add-auto-mode 'makefile-mode "Makefile\\.def")
(add-auto-mode 'cmake-mode "CMakeLists\\.txt\\'" "\\.cmake\\'")
(add-auto-mode 'sws-mode "\\.styl$")
(add-auto-mode 'jade-mode "\\.jade$")
(add-auto-mode 'tcl-mode "\\.ops$")
(add-auto-mode 'markdown-mode "\\.md")
(add-auto-mode 'c++-mode "\\.h$")
(add-auto-mode 'js-mode "\\.json\\'")
(add-auto-mode 'js2-mode "\\.js\\'")
(add-auto-mode 'web-mode "\\.jsx\\'")
(add-auto-mode 'octave-mode "\\.m\\'")
(add-auto-mode 'web-mode "\\.html\\'")
(add-auto-mode 'sass-mode "\\.scss\\'")

(put 'downcase-region 'disabled nil)
(put 'narrow-to-defun 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(setq dired-dwim-target t)
(setq tramp-default-method "ssh")
(setq frame-title-format '("" "%b @ Emacs " emacs-version))
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq initial-major-mode 'fundamental-mode)
(setq magit-last-seen-setup-instructions "1.4.0")
(setq markdown-command "marked --gfm")
(setq next-screen-context-lines 10)
(setq vc-follow-symlinks t)
(setq visible-bell t)
(setq x-select-enable-clipboard t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default truncate-lines t)
(setq indent-line-function 'insert-tab)
(set-fontset-font t 'han (font-spec :name "Songti SC"))
(setq cursor-type 'bar)
(blink-cursor-mode 0)


(defun font-existsp (font)
    (if (null (x-list-fonts font))
        nil t))
(set-face-attribute 'default nil :height 140)
(when (font-existsp "Source Code Pro")
      (set-default-font "Source Code Pro 14"))

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

(setq ring-bell-function 'my-bell-function)
(defun my-bell-function ()
  (unless (memq this-command
    	'(mwheel-scroll down up next-line previous-line
              backward-char forward-char))
    (ding)))

(provide 'lge-custom)
;;; lge-custom.el ends here
