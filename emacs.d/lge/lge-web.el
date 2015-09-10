;;; lge-web --- Configuration for web development.
;;; Commentary:
;;; Code:
(require-package 'web-mode)
(require 'web-mode)
(require-package 'emmet-mode)
(require 'emmet-mode)
(require-package 'yasnippet)
(require 'yasnippet)
(require-package 'flycheck)
(require 'flycheck)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

(add-hook
 'web-mode-hook
 (lambda ()
   (flycheck-mode 1)
   (emmet-mode 1)
   (yas-minor-mode 1)
   (when (equal web-mode-content-type "javascript")
       (web-mode-set-content-type "jsx"))))

(add-hook
 'json-mode-hook
 (lambda ()
   (flycheck-mode 1)))

(provide 'lge-web)
;;; lge-web.el ends here
