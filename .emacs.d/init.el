
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

(lge-add-to-load-path-recursive "~/.emacs.d/setup/")

(require 'purcell-benchmarking)

(defconst *spell-check-support-enabled* nil)
(defconst *is-a-mac* (eq system-type 'darwin))
;; (defconst *is-cocoa-emacs* (and *is-a-mac* (eq window-system 'ns)))
(defconst *is-cocoa-emacs* *is-a-mac*)

(require 'lge-elpa)
(require 'lge-base)

(require 'lge-auto-complete)
(require 'lge-autopair)
(require 'lge-diminish)
(require 'lge-dired)
(require 'lge-ibuffer)
(require 'lge-ido)
(require 'lge-isearch)
(require 'lge-maxframe)
(require 'lge-osx-keys)
(require 'lge-paredit)
(require 'lge-recentf)
(require 'lge-uniquify)
(require 'lge-windows)
(require 'lge-xterm)
(require 'lge-hippie-expand)
(require 'lge-mmm)
(require 'lge-yasnippet)
(require 'lge-cua)
(require 'lge-undo-tree)

(require 'lge-edit)
(require 'lge-mouse)
(require 'lge-files)
(require 'lge-system-utils)
(require 'lge-tmp)
(require 'lge-register)

(require 'lge-git)

(require 'lge-js)
(require 'lge-tex)
(require 'lge-ruby-mode)

(require-package 'scratch)

(require-package 'midnight)
(require 'midnight)

(require-package 'cmake-mode)
(require 'cmake-mode)

(require-package 'jade-mode)
(require 'jade-mode)

(require-package 'stylus-mode)
(require 'stylus-mode)

(require-package 'gnuplot)

(require-package 'lua-mode)
(require 'lua-mode)

(require-package 'htmlize)

(require-package 'dsvn)

(require-package 'dash)
(require 'dash)

(require-package 's)
(require 's)

(require-package 'f)
(require 'f)

(when *is-a-mac*
  (require-package 'osx-location))

(require-package 'regex-tool)

(let ((custom-file (expand-file-name "custom.el" "~/.emacs.d/lge/")))
  (when (file-exists-p custom-file)
    (load custom-file)))

(require 'lge-custom)

(require 'lge-bindings)

(message "init completed in %.2fms"
         (sanityinc/time-subtract-millis (current-time) before-init-time))

;; (require 'purcell-crontab)
;; (require 'purcell-textile)
;; (require 'purcell-markdown)
;; (require 'purcell-csv)
;; (require 'purcell-erlang)
;; (require 'purcell-php)
;; (require 'purcell-org)
;; (require 'purcell-nxml)
;; (require 'purcell-css)
;; (require 'purcell-haml)
;; (require 'purcell-python-mode)
;; (require 'purcell-haskell)
;; (require 'purcell-rails)
;; (require 'purcell-sql)
