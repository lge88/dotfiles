(defun lge-add-to-load-path (path)
  "Add given path to load path"
  (interactive)
  (add-to-list 'load-path path))

(defun lge-add-to-load-path-recursive (path)
  "Add given path and its subdirectories to load path"
  (interactive)
  (add-to-list 'load-path path)
  (let ((default-directory path))
      (normal-top-level-add-subdirs-to-load-path)))

(lge-add-to-load-path-recursive "~/.emacs.d/lge/")

(defconst *spell-check-support-enabled* nil)
(defconst *is-a-mac* (eq system-type 'darwin))
(defconst *is-cocoa-emacs* *is-a-mac*)

;; (package-refresh-contents)

(require 'lge-elpa)
(require 'lge-base)

(require 'lge-auto-complete)
(require 'lge-autopair)
(require 'lge-diminish)
;; (require 'lge-org)
(require 'lge-ispell)
;;; (require 'lge-google-translate)
(require 'lge-projectile)

(require 'lge-dired)
;;; (require 'lge-ido)
;; (require 'lge-isearch)
;; (require 'lge-maxframe)
(require 'lge-osx-keys)
(require 'lge-paredit)
(require 'lge-recentf)
(require 'lge-uniquify)
(require 'lge-windows)
(require 'lge-xterm)
(require 'lge-hippie-expand)
;;; (require 'lge-mmm)
(require 'lge-yasnippet)

(require 'lge-edit)
(require 'lge-mouse)
(require 'lge-files)
(require 'lge-system-utils)
(require 'lge-scratch)
;; (require 'lge-register)

;; (require 'lge-git)

;; (require 'lge-js)
;; (require 'lge-emmet)
;; (require 'lge-tss)
(require 'lge-web)
(require 'lge-white-board)
(require 'lge-c)
;; (require 'lge-tcl)
;; (require 'lge-sh)
;; (require 'lge-python)
(require 'lge-tex)
;; (require 'lge-ruby-mode)
;; (require 'lge-clojure)

(require-package 'scratch)

(require-package 'editorconfig)
(require 'editorconfig)

(require-package 'go-mode)
(require 'go-mode)

;; (require 're-builder)

(require 'undo-tree)
(global-undo-tree-mode 1)

(require-package 'midnight)
(require 'midnight)

(require-package 'cmake-mode)
(require 'cmake-mode)

;; (require-package 'jade-mode)
;; (require 'jade-mode)

;; (require-package 'stylus-mode)
;; (require 'stylus-mode)

;; (require-package 'gnuplot)

;; (require-package 'lua-mode)
;; (require 'lua-mode)

;; (require-package 'htmlize)

;; (require-package 'dsvn)

(require-package 'dash)
(require 'dash)

(require-package 's)
(require 's)

(require-package 'f)
(require 'f)

(require-package 'markdown-mode)
(require 'markdown-mode)

(require-package 'smooth-scrolling)
(require 'smooth-scrolling)

;; (require-package 'rainbow-delimiters)
;; (require 'rainbow-delimiters)
;; (rainbow-delimiters-mode 1)

;; (when *is-a-mac*
;;   (require-package 'osx-location))

(setq custom-file "~/.emacs.d/lge/custom.el")
(load custom-file)

(require 'lge-custom)

(require 'lge-bindings)
(server-start)
