
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

(require 'lge-elpa)
(require 'lge-base)

(require 'lge-auto-complete)
(require 'lge-autopair)
(require 'lge-diminish)
(require 'lge-org)
(require 'lge-ispell)
;;; FIXME: doesn't work yet
;; (require 'lge-google-translate)
(require 'lge-goto)

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
(require 'lge-scratch)
(require 'lge-register)

(require 'lge-git)

(require 'lge-js)
(require 'lge-white-board)
(require 'lge-c)
(require 'lge-tcl)
(require 'lge-sh)
(require 'lge-python)
(require 'lge-tex)
(require 'lge-ruby-mode)
(require 'lge-clojure)

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

(require-package 'markdown-mode)
(require 'markdown-mode)

(when *is-a-mac*
  (require-package 'osx-location))

(require 'lge-custom)
(require 'lge-theme)

(require 'lge-bindings)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(cua-mode t nil (cua-base))
 '(cursor-type (quote bar) t)
 '(custom-enabled-themes (quote (sanityinc-tomorrow-eighties)))
 '(custom-safe-themes (quote ("bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default)))
 '(fci-rule-color "#073642")
 '(helm-mode t)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map (quote ((20 . "#dc322f") (40 . "#cb4b16") (60 . "#b58900") (80 . "#859900") (100 . "#2aa198") (120 . "#268bd2") (140 . "#d33682") (160 . "#6c71c4") (180 . "#dc322f") (200 . "#cb4b16") (220 . "#b58900") (240 . "#859900") (260 . "#2aa198") (280 . "#268bd2") (300 . "#d33682") (320 . "#6c71c4") (340 . "#dc322f") (360 . "#cb4b16"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-selection ((t (:background "black" :underline t)))))
(put 'dired-find-alternate-file 'disabled nil)
