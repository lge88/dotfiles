(require-package 'json)
(when (>= emacs-major-version 24)
  (require-package 'js2-mode)
  (require-package 'ac-js2))
(require-package 'js-comint)
(require-package 'rainbow-delimiters)
(require-package 'coffee-mode)

(require-package 'js2-mode)
(require 'js)
(require 'js2-mode)

(defcustom preferred-javascript-mode
  (first (remove-if-not #'fboundp '(js-mode js2-mode)))
  "Javascript mode to use for .js files."
  :type 'symbol
  :group 'programming
  :options '(js-mode js2-mode))
(defvar preferred-javascript-indent-level 2)

;; Need to first remove from list if present, since elpa adds entries too, which
;; may be in an arbitrary order
(eval-when-compile (require 'cl))
(setq auto-mode-alist (cons `("\\.js\\(\\.erb\\)?\\'" . ,preferred-javascript-mode)
                            (loop for entry in auto-mode-alist
                                  unless (eq preferred-javascript-mode (cdr entry))
                                  collect entry)))

(add-auto-mode 'js-mode "\\.json\\'")

(defun lge-console-time-region (start end str)
  "time the region using console.time/console.timeEnd"
  (interactive "r\nsconsole.time with message: ")
  (let ((str1 (concat "console.time( \"" str "\" );"))
        (str2 (concat "console.timeEnd( \"" str "\" );")))
    (goto-char end)
    (end-of-line)
    (newline-and-indent)
    (newline-and-indent)
    (insert str2)
    (goto-char start)
    (back-to-indentation)
    (insert str1)
    (newline-and-indent)
    (newline-and-indent)))

(defun lge-toggle-js2-js-mode ()
  "DOCSTRING"
  (interactive)
  (if (string= major-mode "js-mode")
      (js2-mode)
    (js-mode)))

(defun lge-eval-node-js-on-region-or-buffer (start end)
  "DOCSTRING"
  (interactive "r")
  (if mark-active
      (progn
        (shell-command-on-region start end "node" "*js*")
        (display-buffer "*js*"))
    (progn
      (shell-command-on-region (point-min) (point-max) "node" "*js*")
      (display-buffer "*js*"))))

(defun lge-eval-node-js-on-region-and-replace (start end)
  "DOCSTRING"
  (interactive "r")
  (if mark-active
      (shell-command-on-region start end "node" t)
    (shell-command-on-region (point-min) (point-max) "node" t)))

(require-package 's)
(require-package 'dash)
(require 's)
(defun lge-gen-sig-from-matches (matches method-type)
  "Generate method signatures from the match results"
  (let (join-str)
    (if (string= method-type "class")
        (setq join-str ".")
      (setq join-str "::"))
    (mapconcat
     (lambda (m) (let (cls meth sig)
                   (setq cls (nth 1 m))
                   (setq meth (nth 2 m))
                   (setq sig (nth 3 m))
                   (concat "// " cls join-str meth "(" sig ")")))
     matches
     "\n")))

(defun lge-uniq-string-list (lst)
  (let ((-compare-fn
         (lambda
           (a b) (string= (car a) (car b)))))
    (-uniq lst)))

(defun lge-grep-functions (str)
  "Given string, return a list of functions."
  (let (pattern matches res)
    (setq pattern
          (concat
           "\\(?:"
           "^var +\\(.*\\) += +function"
           "\\|"
           "^function +\\([^(]+\\)"
           "\\)"
           ))
    (setq matches (s-match-strings-all pattern str))
    (setq res (mapcar
      (lambda (match)
        (if (>= (length match) 3) (nth 2 match) (nth 1 match)))
      matches))
    ;; (-uniq res)
    ))

(defun lge-grep-cls-methods (str cls-name)
  "Given string and class name, return a list of class methods.
Each item in the list is of form (\"method-name\" . \"method-signature\")"
  (let (pattern matches res)
    (setq pattern
          (concat
           "^ *"
           cls-name
           "\.\\([^. ]*\\) *= * function *(\\([^)]*\\)) *"
           ))
    (setq matches (s-match-strings-all pattern str))
    (setq res (mapcar
      (lambda (match) (cons (nth 1 match) (nth 2 match)))
      matches))
    ;; (lge-uniq-string-list res)
    ))

(defun lge-grep-ins-methods (str cls-name)
  "Given string and class name, return a list of instance methods.
Each item in the list is of form (\"method-name\" . \"method-signature\")"
  (let (pattern matches res)
    (setq pattern
          (concat
           "^ *"
           cls-name
           "\.prototype\.\\([^. ]*\\) *= * function *(\\([^)]*\\)) *"
           ))
    (setq matches (s-match-strings-all pattern str))
    (setq res (mapcar
      (lambda (match)(cons (nth 1 match) (nth 2 match)))
      matches))
    ;;(lge-uniq-string-list res)
    ))

(defun lge-insert-methods (cls meths sep)
  (mapc
   (lambda (meth)
     (let ((name (car meth)) (sig (cdr meth)))
       (insert "//   " cls sep name "(" sig ")\n")
       )
     )
   meths
   ))

(defun lge-insert-outline-for-buffer ()
  "Grep all the functions, ClassName.method and ClassName.prototype.method,
insert to current position."
  (interactive)
  (when mark-active
    (delete-region (region-beginning) (region-end)))

  (let (buf-str funcs insert-methods)
    (setq buf-str (buffer-substring-no-properties (point-min) (point-max)))
    (setq funcs (lge-grep-functions buf-str))

    ;; Insert functions or classes
    (insert "// FUNCTIONS:\n")
    (mapc (lambda (f) (insert "//   " f "\n")) funcs)

    ;; Insert methods
    (mapc
     (lambda
       (f)
       (let (ins-methods cls-methods)
         (setq cls-methods (lge-grep-cls-methods buf-str f))
         (setq ins-methods (lge-grep-ins-methods buf-str f))

         (when (> (length cls-methods) 0)
           (insert "// //\n// [" f "] class methods:\n")
           (lge-insert-methods f cls-methods "."))

         (when (> (length ins-methods) 0)
           (insert "// //\n// [" f "] instance methods:\n")
           (lge-insert-methods f ins-methods "::"))
         )
       ) funcs)
    )
)

(defun lge-disable-leading-and-trailing-space-in-brackets ()
  (interactive)
  (let (par-re-l par-re-r bracket-re-l bracket-re-r start end)
    (setq par-re-l "( +\\(.*[^ ]\\) *)")
    (setq par-re-r "( *\\(.*[^ ]\\) +)")
    (setq bracket-re-l "\\[ +\\(.*[^ ]\\) *\\]")
    (setq bracket-re-r "\\[ *\\(.*[^ ]\\) +\\]")
    (setq start (if mark-active (point) (point-min)))
    (setq end (if mark-active (mark) (point-max)))
    (dotimes (i 3)
      (replace-regexp par-re-l "(\\1)" nil start end)
      (replace-regexp par-re-r "(\\1)" nil start end)
      (replace-regexp bracket-re-l "[\\1]" nil start end)
      (replace-regexp bracket-re-r "[\\1]" nil start end))
    )
  )

(defun lge-enable-leading-and-trailing-space-in-brackets ()
  (interactive)
  (lge-disable-leading-and-trailing-space-in-brackets)
  (let (par-re bracket-re start end)
    (setq par-re "(\\([^ ].*[^ ]\\))")
    (setq bracket-re "\\[\\([^ ].*[^ ]\\)\\]")
    (setq start (if mark-active (point) (point-min)))
    (setq end (if mark-active (mark) (point-max)))
    (dotimes (i 3)
      (replace-regexp par-re "( \\1 )" nil start end)
      (replace-regexp bracket-re "[ \\1 ]" nil start end))
    )
  )

(defalias 'rn 'js2r-rename-var)
(defalias 'lt 'js2r-log-this)
(global-set-key (kbd "<f10>") 'lge-eval-node-js-on-region-or-buffer)
(global-set-key (kbd "<f11>") 'lge-eval-node-js-on-region-and-replace)

;; js2-mode
(after-load 'js2-mode
  (add-hook 'js2-mode-hook '(lambda () (setq mode-name "JS2"))))

(setq js2-use-font-lock-faces t
      js2-mode-must-byte-compile nil
      js2-basic-offset preferred-javascript-indent-level
      js2-indent-on-enter-key t
      js2-auto-indent-p t
      js2-bounce-indent-p nil)

(after-load 'js2-mode
  (js2-imenu-extras-setup))

;; js-mode
(setq js-indent-level preferred-javascript-indent-level)


;; standard javascript-mode
(setq javascript-indent-level preferred-javascript-indent-level)

(add-to-list 'interpreter-mode-alist (cons "node" preferred-javascript-mode))


;;; Coffeescript

(after-load 'coffee-mode
  (setq coffee-js-mode preferred-javascript-mode
        coffee-tab-width preferred-javascript-indent-level))

(add-to-list 'auto-mode-alist '("\\.coffee\\.erb\\'" . coffee-mode))

;; ---------------------------------------------------------------------------
;; Run and interact with an inferior JS via js-comint.el
;; ---------------------------------------------------------------------------

;; (setenv "NODE_NO_READLINE" "1")
;; (setq inferior-js-program-command "node --interactive")

;; (defvar inferior-js-minor-mode-map (make-sparse-keymap))
;; (define-key inferior-js-minor-mode-map "\C-x\C-e" 'js-send-last-sexp)
;; (define-key inferior-js-minor-mode-map "\C-\M-x" 'js-send-last-sexp-and-go)
;; (define-key inferior-js-minor-mode-map "\C-cb" 'js-send-buffer)
;; (define-key inferior-js-minor-mode-map "\C-c\C-b" 'js-send-buffer-and-go)
;; (define-key inferior-js-minor-mode-map "\C-cl" 'js-load-file-and-go)

;; (define-minor-mode inferior-js-keys-mode
;;   "Bindings for communicating with an inferior js interpreter."
;;   nil " InfJS" inferior-js-minor-mode-map)

;; (dolist (hook '(js2-mode-hook js-mode-hook))
;;   (add-hook hook 'inferior-js-keys-mode))

;; ---------------------------------------------------------------------------
;; Alternatively, use skewer-mode
;; ---------------------------------------------------------------------------

;; (when (featurep 'js2-mode)
;;   (require-package 'skewer-mode)
;;   (after-load 'skewer-mode
;;     (add-hook 'skewer-mode-hook
;;               (lambda () (inferior-js-keys-mode -1)))))

(require-package 'js2-refactor)
(require 'js2-refactor)
(js2r-add-keybindings-with-prefix "C-c C-m")

(require 'typescript)

(provide 'lge-js)
