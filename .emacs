(message system-name)

(setq home-directory (getenv "HOME"))
(setq dot-emacs-file (substitute-in-file-name "$HOME/.emacs"))
(setq dot-files-directory (substitute-in-file-name "$HOME/.dotfiles"))
(setq dropbox-directory
      (concat home-directory "/Dropbox"))
(setq develop-directory
      (concat home-directory "/Develop"))
(setq js-develop-directory
      (concat develop-directory "/js"))
(setq toolbox-directory
      (concat dropbox-directory "/toolbox"))
(setq js-app-directory
      (concat js-develop-directory "/apps"))
(setq dot-bashrc-file
      (concat toolbox-directory "/bash/dot_bashrc"))
(setq elisp-directory
      (concat toolbox-directory "/elisp"))
(setq elpa-directory
      (concat elisp-directory "/elpa"))
(setq custom-keys-file
      (concat elisp-directory "/lge-keys.el"))
(setq vendor-directory
      (concat elisp-directory "/vendor"))
(setq custom-snippet-directory
      (concat toolbox-directory "/snippets"))

(add-to-list 'load-path elisp-directory)
(add-to-list 'load-path (concat elisp-directory "/mine"))
(add-to-list 'load-path vendor-directory)

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
(display-time)
(setq next-screen-context-lines 10)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq x-select-enable-clipboard t)
(setq frame-title-format '("" "%b @ Emacs " emacs-version))

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; file associations:
(setq auto-mode-alist (cons '(".*bashrc.*" . sh-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".*bash_.*" . sh-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".*emacs_bash.*" . sh-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".*emacs\\.bmk.*" . emacs-lisp-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("Makefile\\.def" . makefile-mode) auto-mode-alist))

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

;; color-theme settings:
;; (require 'color-theme)
;; (eval-after-load "color-theme"
;;   '(progn
;;      (color-theme-hober)))

(add-to-list 'load-path (concat vendor-directory "/yasnippet"))
(require 'yasnippet)
(yas--initialize)
(setq yas/snippet-dirs
      `(,(concat vendor-directory "/yasnippet/snippets")
        ,custom-snippet-directory))
(yas/reload-all)
(yas/global-mode 1)

(add-to-list 'load-path (concat vendor-directory "/auto-complete"))
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode 1)
(setq ac-auto-start 3)
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
   "js2-mode" "lisp-mode" "sgml-mode" "conf-space-mode"
   "tcl-mode" "c++mode" "c-mode" "sh-mode" "make-mode"
   "cmake-mode" "python-mode" "makefile-gmake-mode"
   ))

(load-library "lge-js2.el")

;; ;; autopair settings:
;; (require 'autopair)
;; (eval-after-load "autopair"
;;   '(progn
;;      (autopair-global-mode 1)

;;      (setq my-autopair-off-modes
;;            '(
;;              ;; js2-mode
;;              ))
;;      (dolist (m my-autopair-off-modes)
;;        (add-hook (intern (concat (symbol-name m) "-hook"))
;;                  #'(lambda () (setq autopair-dont-activate t))))))

;; (eval-after-load "js2-mode"
;;   '(progn
;;      (if (and (boundp 'my-autopair-off-modes)
;;               (not (memq 'js2-mode my-autopair-off-modes)))
;;          (setq js2-mirror-mode nil))))

;; ;; Use espresso-mode for js indentation
;; (autoload #'espresso-mode "espresso" "Start espresso-mode" t)
;; (defun my-js2-indent-function ()
;;   (interactive)
;;   (save-restriction
;;     (widen)
;;     (let* ((inhibit-point-motion-hooks t)
;;            (parse-status (save-excursion (syntax-ppss (point-at-bol))))
;;            (offset (- (current-column) (current-indentation)))
;;            (indentation (espresso--proper-indentation parse-status))
;;            node)
;;       (save-excursion
;;         (back-to-indentation)
;;         (if (looking-at "case\\s-")
;;             (setq indentation (+ indentation (/ espresso-indent-level 2))))

;;         (setq node (js2-node-at-point))
;;         (when (and node
;;                    (= js2-NAME (js2-node-type node))
;;                    (= js2-VAR (js2-node-type (js2-node-parent node))))
;;           (setq indentation (+ 4 indentation))))
;;       (indent-line-to indentation)
;;       (when (> offset 0) (forward-char offset)))))

;; (defun my-indent-sexp ()
;;   (interactive)
;;   (save-restriction
;;     (save-excursion
;;       (widen)
;;       (let* ((inhibit-point-motion-hooks t)
;;              (parse-status (syntax-ppss (point)))
;;              (beg (nth 1 parse-status))
;;              (end-marker (make-marker))
;;              (end (progn (goto-char beg) (forward-list) (point)))
;;              (ovl (make-overlay beg end)))
;;         (set-marker end-marker end)
;;         (overlay-put ovl 'face 'highlight)
;;         (goto-char beg)
;;         (while (< (point) (marker-position end-marker))
;;           (beginning-of-line)
;;           (unless (looking-at "\\s-*$")
;;             (indent-according-to-mode))
;;           (forward-line))
;;         (run-with-timer 0.5 nil '(lambda(ovl)
;;                                    (delete-overlay ovl)) ovl)))))

;; (defun my-js2-mode-hook ()
;;   (require 'espresso)
;;   (setq espresso-indent-level 2
;;         indent-tabs-mode nil
;;         c-basic-offset 4)
;;   (c-toggle-auto-state 0)
;;   (c-toggle-hungry-state 1)
;;   (set (make-local-variable 'indent-line-function) 'my-js2-indent-function)
;;   (if (featurep 'js2-highlight-vars)
;;       (js2-highlight-vars-mode))
;;   (message "My JS2 hook"))

;; (add-hook 'js2-mode-hook 'my-js2-mode-hook)

(require 'register-list)
(require 'register)
(eval-after-load "register-list"
  '(progn
     (global-set-key (kbd "C-x r v") 'register-list)
     (global-set-key (kbd "C-x r C-l") 'list-registers)
     (set-register ?a `(file . ,js-app-directory))
     (set-register ?b `(file . ,dot-bashrc-file))
     (set-register ?c `(file . ,dot-files-directory))
     (set-register ?d `(file . ,develop-directory))
     (set-register ?e `(file . ,elisp-directory))
     (set-register ?i `(file . ,dot-emacs-file))
     (set-register ?j `(file . ,js-develop-directory))
     (set-register ?k `(file . ,custom-keys-file))
     (set-register ?h `(file . ,home-directory))
     (set-register ?s `(file . ,custom-snippet-directory))
     (set-register ?t `(file . ,toolbox-directory))
     ))

;; (require 'grep-edit)
(require 'sr-speedbar)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-skip-other-window-p t)

;; websocket settings:
;; (add-to-list 'load-path (concat vendor-directory "/emacs-websocket"))
;; (require 'websocket)

;; opensees client settings:
;; (add-to-list 'load-path (concat vendor-directory "/opensees-client"))
;; (require 'ops-client)

(require 'json-reformat)

(require 'midnight)

(require 'ediff-trees)

(require 'magit)
(require 'magit-svn)
(when (string= system-type "darwin") (setq magit-git-executable "/usr/local/git/bin/git"))

(require 'cmake-mode)
;; (setq auto-mode-alist
;;       (append '(("CMakeLists\\.txt\\'" . cmake-mode)
;;                 ("\\.cmake\\'" . cmake-mode))
;;               auto-mode-alist))
(setq auto-mode-alist (cons '("CMakeLists\\.txt\\'" . cmake-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cmake\\'" . cmake-mode) auto-mode-alist))


(require 'jpeg-mode)

;; (require 'ibus)
;; (add-hook 'after-init-hook 'ibus-mode-on)
;; (ibus-define-common-key ?\C-\s nil)
;; (ibus-define-common-key ?\C-/ nil)
;; (global-set-key (kbd "C-S-SPC") 'ibus-toggle)
;; (setq ibus-cursor-color '("red" "dodger blue" "limegreen"))

(setq bookmark-default-file "~/.emacs.bmk")

(add-to-list 'load-path (concat vendor-directory "/jade-mode"))
(require 'sws-mode)
(require 'jade-mode)    
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

(add-to-list 'auto-mode-alist '("\\.ops$" . tcl-mode))

(add-to-list 'load-path (concat vendor-directory "/markdown-mode"))
(autoload 'markdown-mode
  "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; (eval-after-load "dired-aux"
;;   '(add-to-list 'dired-compress-file-suffixes 
;;                 '("\\.zip\\'" ".zip" "unzip")))

(require 'lge-keys)

;; ;; ;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(Man-notify-method (quote bully))
;;  '(ansi-color-names-vector ["black" "red" "green" "yellow" "dodger blue" "magenta" "cyan" "white"])
;;  '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
;;  '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
;;  '(custom-enabled-themes nil)
;;  '(ibuffer-saved-filter-groups (quote (("direcotories" ("directories" (saved . "directories")) ("documents" (saved . "documents")) ("directories" (saved . "directories"))) ("documents" ("documents" (saved . "documents"))))))
;;  '(ibuffer-saved-filters (quote (("sketchit-lite" ((filename . "^/home/GL/Dropbox/projects/websites/sketchit-lite.*"))) ("directories" ((mode . dired-mode))) ("documents" ((not mode . dired-mode) (name . "^[^\\*]"))) ("gnus" ((or (mode . message-mode) (mode . mail-mode) (mode . gnus-group-mode) (mode . gnus-summary-mode) (mode . gnus-article-mode)))) ("programming" ((or (mode . emacs-lisp-mode) (mode . cperl-mode) (mode . c-mode) (mode . java-mode) (mode . idl-mode) (mode . lisp-mode)))))))
;;  '(markdown-command "marked --gfm")
;;  '(send-mail-function (quote smtpmail-send-it)))

;; ;; (custom-set-variables
;; ;;  ;; custom-set-variables was added by Custom.
;; ;;  ;; If you edit it by hand, you could mess it up, so be careful.
;; ;;  ;; Your init file should contain only one such instance.
;; ;;  ;; If there is more than one, they won't work right.
;; ;;  '(Man-notify-method (quote bully))
;; ;;  '(ansi-color-names-vector ["black" "red" "green" "yellow" "dodger blue" "magenta" "cyan" "white"])
;; ;;  '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
;; ;;  '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
;; ;;  '(custom-enabled-themes nil)
;; ;;  '(ibuffer-saved-filter-groups (quote (("direcotories" ("directories" (saved . "directories")) ("documents" (saved . "documents")) ("directories" (saved . "directories"))) ("documents" ("documents" (saved . "documents"))))))
;; ;;  '(ibuffer-saved-filters (quote (("sketchit-lite" ((filename . "^/home/GL/Dropbox/projects/websites/sketchit-lite.*"))) ("directories" ((mode . dired-mode))) ("documents" ((not mode . dired-mode) (name . "^[^\\*]"))) ("gnus" ((or (mode . message-mode) (mode . mail-mode) (mode . gnus-group-mode) (mode . gnus-summary-mode) (mode . gnus-article-mode)))) ("programming" ((or (mode . emacs-lisp-mode) (mode . cperl-mode) (mode . c-mode) (mode . java-mode) (mode . idl-mode) (mode . lisp-mode)))))))
;; ;;  '(markdown-command "marked --gfm")
;; ;;  '(send-mail-function (quote smtpmail-send-it)))
;; ;; (custom-set-faces
;; ;;  ;; custom-set-faces was added by Custom.
;; ;;  ;; If you edit it by hand, you could mess it up, so be careful.
;; ;;  ;; Your init file should contain only one such instance.
;; ;;  ;; If there is more than one, they won't work right.
;; ;;  '(font-lock-variable-name-face ((t (:foreground "dodger blue")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-notify-method (quote bully))
 '(ansi-color-names-vector ["black" "red" "green" "yellow" "dodger blue" "magenta" "cyan" "white"])
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(speedbar-show-unknown-files t)
 '(ibuffer-saved-filter-groups (quote (("direcotories" ("directories" (saved . "directories")) ("documents" (saved . "documents")) ("directories" (saved . "directories"))) ("documents" ("documents" (saved . "documents"))))))
 '(ibuffer-saved-filters (quote (("sketchit-lite" ((filename . "^/home/GL/Dropbox/projects/websites/sketchit-lite.*"))) ("directories" ((mode . dired-mode))) ("documents" ((not mode . dired-mode) (name . "^[^\\*]"))) ("gnus" ((or (mode . message-mode) (mode . mail-mode) (mode . gnus-group-mode) (mode . gnus-summary-mode) (mode . gnus-article-mode)))) ("programming" ((or (mode . emacs-lisp-mode) (mode . cperl-mode) (mode . c-mode) (mode . java-mode) (mode . idl-mode) (mode . lisp-mode)))))))
 '(markdown-command "marked --gfm")
 '(send-mail-function (quote smtpmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-variable-name-face ((t (:foreground "dodger blue")))))
