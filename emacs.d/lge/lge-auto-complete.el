(provide 'lge-auto-complete)

(require-package 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(setq ac-expand-on-auto-complete nil)
(setq ac-auto-start nil)
(setq ac-dwim nil)

(define-key ac-mode-map (kbd "S-SPC") 'auto-complete)
(define-key ac-completing-map (kbd "<escape> <tab>") 'ac-stop)
(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)

(ac-config-default)

(dolist (mode '(magit-log-edit-mode log-edit-mode org-mode text-mode haml-mode
                sass-mode yaml-mode csv-mode espresso-mode haskell-mode
                html-mode nxml-mode smarty-mode clojure-mode
                textile-mode markdown-mode tuareg-mode
                js2-mode js-mode lisp-mode sgml-mode conf-space-mode
                tcl-mode c++mode c-mode sh-mode make-mode latex-mode
                cmake-mode python-mode makefile-gmake-mode jade-mode
                js3-mode css-mode less-css-mode sql-mode ielm-mode))
  (add-to-list 'ac-modes mode))

(dolist (hook '(js-mode-hook js2-mode-hook))
  (add-hook hook (lambda ()
                   (add-to-list 'ac-sources 'ac-source-yasnippet))))

;; TODO:
;; Need a good smart tab implementation
;;   1) It tries to yas expand first.
;;   2) Then try auto complete
;;   3) Then try indent region
;; Need to somehow bind it to <tab> for all modes

(defun lge-auto-complete (args)
  (interactive "P")
  (unless (yas/expand)
    (progn
      (delete-backward-char 1)
      (auto-complete))))

;; Doesn't seen to work
(require 'lge-yasnippet)
(add-hook 'yas/minor-mode-hook
          (lambda () (define-key yas/minor-mode-map
                       (kbd "<tab>") 'lge-auto-complete)))


;; (remove-hook 'js-mode-hook (elt js-mode-hook 0))


;; (setq-default ac-sources
;;               '(
;;                 ac-source-imenu
;;                 ac-source-abbrev
;;                 ac-source-words-in-buffer
;;                 ac-source-files-in-current-dir
;;                 ac-source-filename
;;                 ac-source-words-in-all-buffer
;;                 ac-source-dictionary
;;                 ac-source-yasnippet
;;                 ))

;; (dolist (hook '(emacs-lisp-mode-hook))
;;   (add-hook hook (lambda ()
;;                    (setq ac-sources
;;                          '(
;;                            ac-source-functions
;;                            ac-source-symbols
;;                            ac-source-yasnippet
;;                            ac-source-filename
;;                            )))))
