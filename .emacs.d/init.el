
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

(require 'purcell-compat)
(require 'purcell-utils)
(require 'purcell-site-lisp)
(require 'purcell-elpa)
(require 'purcell-exec-path)

(require-package 'project-local-variables)
(require-package 'diminish)
(require-package 'scratch)
(require-package 'mwe-log-commands)

(require 'lge-wgrep)
(require 'lge-frame-hooks)
(require 'lge-xterm)
(require 'purcell-themes)
(require 'lge-osx-keys)
(require 'purcell-gui-frames)
(require 'purcell-maxframe)
(require 'purcell-proxies)
(require 'lge-dired)
(require 'purcell-isearch)
(require 'purcell-uniquify)
(require 'lge-ibuffer)
(require 'lge-flycheck)

(require 'purcell-recentf)
(require 'lge-ido)
(require 'purcell-hippie-expand)
(require 'lge-auto-complete)
(require 'lge-windows)
(require 'lge-autopair)
(require 'purcell-sessions)
(require 'purcell-fonts)
(require 'purcell-mmm)
(require 'purcell-growl)

(require 'lge-yasnippet)
(require 'lge-cua)

(require 'lge-edit)
(require 'lge-simple)
(require 'lge-files)
(require 'lge-system-utils)
(require 'lge-tmp)
(require 'lge-register)

(require 'lge-git)

(require 'lge-js)
(require 'purcell-crontab)
(require 'purcell-textile)
(require 'purcell-markdown)
(require 'purcell-csv)
(require 'purcell-erlang)
(require 'purcell-php)
(require 'purcell-org)
(require 'purcell-nxml)
(require 'purcell-css)
(require 'purcell-haml)
(require 'purcell-python-mode)
(require 'purcell-haskell)
(require 'purcell-ruby-mode)
(require 'purcell-rails)
(require 'purcell-sql)

(require-package 'midnight)
(require-package 'cmake-mode)
(require 'cmake-mode)
(require-package 'gnuplot)
(require-package 'lua-mode)
(require-package 'htmlize)
(require-package 'dsvn)
(when *is-a-mac*
  (require-package 'osx-location))
(require-package 'regex-tool)

(setq custom-file (expand-file-name "custom.el" "~/.emacs.d/lge/"))
(when (file-exists-p custom-file)
  (load custom-file))

(require 'lge-custom)

(message "init completed in %.2fms"
         (sanityinc/time-subtract-millis (current-time) before-init-time))
(put 'upcase-region 'disabled nil)
