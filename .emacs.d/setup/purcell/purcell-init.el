
(provide 'purcell-init)

;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

(require 'purcell-benchmarking) ;; Measure startup time

;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(defconst *spell-check-support-enabled* nil)
(defconst *is-a-mac* (eq system-type 'darwin))
(defconst *is-cocoa-emacs* (and *is-a-mac* (eq window-system 'ns)))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(require 'purcell-compat)
(require 'purcell-utils)
(require 'purcell-site-lisp) ;; Must come before elpa, as it may provide package.el
(require 'purcell-elpa)      ;; Machinery for installing required packages
(require 'purcell-exec-path) ;; Set up $PATH

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------

(require-package 'wgrep)
(require-package 'project-local-variables)
(require-package 'diminish)
(require-package 'scratch)
(require-package 'mwe-log-commands)

(require 'purcell-frame-hooks)
(require 'purcell-xterm)
(require 'purcell-themes)
(require 'purcell-osx-keys)
(require 'purcell-gui-frames)
(require 'purcell-maxframe)
(require 'purcell-proxies)
(require 'purcell-dired)
(require 'purcell-isearch)
(require 'purcell-uniquify)
(require 'purcell-ibuffer)
(require 'purcell-flycheck)

(require 'purcell-recentf)
(require 'purcell-ido)
(require 'purcell-hippie-expand)
(require 'purcell-auto-complete)
(require 'purcell-windows)
(require 'purcell-sessions)
(require 'purcell-fonts)
(require 'purcell-mmm)
(require 'purcell-growl)

(require 'purcell-editing-utils)

(require 'purcell-darcs)
(require 'purcell-git)

(require 'purcell-crontab)
(require 'purcell-textile)
(require 'purcell-markdown)
(require 'purcell-csv)
(require 'purcell-erlang)
(require 'purcell-javascript)
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

(require 'purcell-paredit)
(require 'purcell-lisp)
(require 'purcell-slime)
(require 'purcell-clojure)
(require 'purcell-common-lisp)

(when *spell-check-support-enabled*
  (require 'purcell-spelling))

(require 'purcell-marmalade)
(require 'purcell-misc)

;; Extra packages which don't require any configuration

(require-package 'gnuplot)
(require-package 'lua-mode)
(require-package 'htmlize)
(require-package 'dsvn)
(when *is-a-mac*
  (require-package 'osx-location))
(require-package 'regex-tool)

;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
(require 'server)
(unless (server-running-p)
  (server-start))


;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))


;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-local" containing personal settings
;;----------------------------------------------------------------------------
(require 'purcell-local nil t)


;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(require 'purcell-locales)

(message "init completed in %.2fms"
         (sanityinc/time-subtract-millis (current-time) before-init-time))

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
