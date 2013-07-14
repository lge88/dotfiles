(message system-name)

(setq home-directory (getenv "HOME"))
(setq dot-emacs-file (substitute-in-file-name "$HOME/.emacs"))
(setq dot-files-directory (substitute-in-file-name "$HOME/.dotfiles"))
(setq dropbox-directory (concat home-directory "/Dropbox"))
(setq develop-directory (concat home-directory "/Develop"))
(setq js-develop-directory (concat develop-directory "/js"))
(setq toolbox-directory (concat dropbox-directory "/toolbox"))
(setq ar-app-directory (concat js-develop-directory "/ifea/lib/ar-structure"))
(setq dot-bashrc-file (concat dot-files-directory "/.bashrc"))
(setq elisp-directory (concat toolbox-directory "/elisp"))
(setq elpa-directory (substitute-in-file-name "$HOME/.emacs.d/elpa"))
(setq custom-keys-file (substitute-in-file-name "$HOME/.emacs.d/lge/lge-keys.el"))
(setq custom-snippet-directory (substitute-in-file-name "$HOME/.emacs.d/snippets"))
;; TODO: use git submodule to manage vendor directory then move it to ~/.emacs.d
(setq vendor-directory (concat elisp-directory "/vendor"))

;; (add-to-list 'load-path elisp-directory)
(add-to-list 'load-path (substitute-in-file-name "$HOME/.emacs.d/lge"))
(add-to-list 'load-path vendor-directory)

(defun my-bell-function ()
  (unless (memq this-command
    	'(mwheel-scroll down up next-line previous-line
              backward-char forward-char))
    (ding)))
(setq ring-bell-function 'my-bell-function)

(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)

(setq visible-bell t)
(setq-default truncate-lines t)
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(global-font-lock-mode 1)
(global-hl-line-mode 1)
(transient-mark-mode 1)
(show-paren-mode 1)
(column-number-mode 1)
(ido-mode 1)
(winner-mode 1)
(setq shell-command-switch "-ic")
(global-auto-revert-mode 1)
(setq next-screen-context-lines 10)
(menu-bar-mode 1)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq x-select-enable-clipboard t)
(setq frame-title-format '("" "%b @ Emacs " emacs-version))
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))
(fset 'yes-or-no-p 'y-or-n-p)

(eval-after-load "js" '(setq js-indent-level 2))

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; file associations:
(setq auto-mode-alist (cons '(".*bashrc.*" . sh-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".*bash_.*" . sh-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".*emacs_bash.*" . sh-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".*emacs\\.bmk.*" . emacs-lisp-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("Makefile\\.def" . makefile-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("CMakeLists\\.txt\\'" . cmake-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cmake\\'" . cmake-mode) auto-mode-alist))

;; package settings:
(require 'package)
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)

;; dired settings:
(require 'dired)
(setq dired-listing-switches "-alh")
(setq dired-auto-revert-buffer t)
(setq wdired-allow-to-change-permissions t)

(require 'python-mode)
(defvar py-mode-map python-mode-map)

;; (require 'evil)
;; (evil-mode 1)
;; (global-set-key (kbd "C-SPC") 'evil-normal-state)
;; (global-set-key (kbd "C-@") 'evil-normal-state)
;; (define-key evil-insert-state-map (kbd "C-SPC") 'evil-normal-state)
;; (define-key evil-emacs-state-map (kbd "C-SPC") 'evil-normal-state)
;; (define-key evil-normal-state-map (kbd "C-SPC") 'evil-normal-state)
;; (define-key evil-insert-state-map (kbd "C-@") 'evil-normal-state)
;; (define-key evil-emacs-state-map (kbd "C-@") 'evil-normal-state)
;; (define-key evil-normal-state-map (kbd "C-@") 'evil-normal-state)
;; (define-key evil-normal-state-map "\C-e" 'evil-end-of-line)
;; (define-key evil-insert-state-map "\C-e" 'evil-end-of-line)
;; (define-key evil-motion-state-map "\C-e" 'evil-end-of-line)



;; ibuffer settings:
(require 'ibuffer)

(setq ibuffer-show-empty-filter-groups nil)
(setq ibuffer-expert t)
(add-hook 'ibuffer-mode-hook (lambda ()
                               (ibuffer-auto-mode 1)
                               ))
(ibuffer)
(ibuffer-switch-to-saved-filter-groups "documents")
;; Enable ibuffer-filter-by-filename to filter on directory names too.
(eval-after-load "ibuf-ext"
  '(define-ibuffer-filter filename
       "Toggle current view to buffers with file or directory name matching QUALIFIER."
     (:description "filename"
                   :reader (read-from-minibuffer "Filter by file/directory name (regexp): "))
     (ibuffer-awhen (or (buffer-local-value 'buffer-file-name buf)
                        (buffer-local-value 'dired-directory buf))
       (string-match qualifier it))))

(require 'autopair)
(autopair-global-mode 1)

;; color-theme settings:
;; (require 'color-theme)
;; (eval-after-load "color-theme"
;;   '(progn
;;      (color-theme-hober)))

(add-to-list 'load-path (concat vendor-directory "/yasnippet"))
(require 'yasnippet)
(yas--initialize)

(setq yas/snippet-dirs
      `(
        ;; ,(substitute-in-file-name "$HOME/.emacs.d/snippets")
        ,custom-snippet-directory
        ,(concat vendor-directory "/yasnippet/snippets")
        ))
(yas/reload-all)
(yas/global-mode 1)

(add-to-list 'load-path (concat vendor-directory "/auto-complete"))
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
;; (global-auto-complete-mode 1)
(setq ac-auto-start nil)
(define-key ac-mode-map (kbd "S-SPC") 'auto-complete)
(define-key ac-completing-map (kbd "<escape> <tab>") 'ac-stop)
(setq ac-dwim t)
(setq-default ac-sources
              '(
                ac-source-yasnippet
                ac-source-abbrev
                ac-source-words-in-buffer
                ac-source-files-in-current-dir
                ac-source-filename
                ac-source-words-in-all-buffer
                ac-source-dictionary
                ))

;; Global mode doesn't work well in daemon mode
(mapc
 '(lambda (m)
    (add-hook (intern (concat m "-hook"))
              #'(lambda ()
                  (yas/minor-mode 1)
                  (nlinum-mode 1)
                  (auto-complete-mode 1)
                  )))
 '(
   "js2-mode" "js-mode" "lisp-mode" "sgml-mode" "conf-space-mode"
   "tcl-mode" "c++mode" "c-mode" "sh-mode" "make-mode"
   "cmake-mode" "python-mode" "makefile-gmake-mode" "jade-mode"
   ))

;; (load-library "lge-js2.el")

(require 'register-list)
(require 'register)
(eval-after-load "register-list"
  '(progn
     (global-set-key (kbd "C-x r v") 'register-list)
     (global-set-key (kbd "C-x r C-l") 'list-registers)
     (set-register ?a `(file . ,ar-app-directory))
     (set-register ?b `(file . ,dot-bashrc-file))
     (set-register ?c `(file . ,dot-files-directory))
     (set-register ?d `(file . ,develop-directory))
     (set-register ?e `(file . ,(substitute-in-file-name "$HOME/.emacs.d")))
     (set-register ?i `(file . ,dot-emacs-file))
     (set-register ?j `(file . ,js-develop-directory))
     (set-register ?k `(file . ,custom-keys-file))
     (set-register ?h `(file . ,home-directory))
     (set-register ?s `(file . ,custom-snippet-directory))
     (set-register ?t `(file . ,toolbox-directory))
     (switch-to-buffer "*scratch*")
     (point-to-register ?\s)
     ))

(require 'sr-speedbar)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-skip-other-window-p t)

(require 'json-reformat)
(require 'midnight)
(require 'ediff-trees)

(require 'magit)
(require 'magit-svn)
(when (string= system-type "darwin") (setq magit-git-executable "/usr/local/git/bin/git"))

(require 'jpeg-mode)

(add-to-list 'load-path (concat vendor-directory "/jade-mode"))
(require 'sws-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
(add-to-list 'auto-mode-alist '("\\.ops$" . tcl-mode))

(add-to-list 'load-path (concat vendor-directory "/markdown-mode"))
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

(eval-after-load "dired-aux"
  '(add-to-list 'dired-compress-file-suffixes
                '("\\.zip\\'" ".zip" "unzip")))

(require 'lge-keys)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-notify-method (quote bully))
 '(ansi-color-names-vector ["black" "red" "green" "yellow" "dodger blue" "magenta" "cyan" "white"])
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(custom-enabled-themes (quote (manoj-dark)))
 '(ibuffer-saved-filter-groups (quote (("direcotories" ("directories" (saved . "directories")) ("documents" (saved . "documents")) ("directories" (saved . "directories"))) ("documents" ("documents" (saved . "documents"))))))
 '(ibuffer-saved-filters (quote (("sketchit-lite" ((filename . "^/home/GL/Dropbox/projects/websites/sketchit-lite.*"))) ("directories" ((mode . dired-mode))) ("documents" ((not mode . dired-mode) (name . "^[^\\*]"))) ("gnus" ((or (mode . message-mode) (mode . mail-mode) (mode . gnus-group-mode) (mode . gnus-summary-mode) (mode . gnus-article-mode)))) ("programming" ((or (mode . emacs-lisp-mode) (mode . cperl-mode) (mode . c-mode) (mode . java-mode) (mode . idl-mode) (mode . lisp-mode)))))))
 '(js2-basic-offset 2)
 '(markdown-command "marked --gfm")
 '(send-mail-function (quote smtpmail-send-it))
 '(speedbar-show-unknown-files t)
 '(vc-follow-symlinks nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-variable-name-face ((t (:foreground "dodger blue")))))
(put 'downcase-region 'disabled nil)
