
(require 'js-comint)
(setq lge-nvm-path (expand-file-name "~/.nvm"))
(setq lge-node-version-in-use "v0.10.35")
(setq lge-node-home (format "%s/%s" lge-nvm-path lge-node-version-in-use))
(setq lge-node-bin (format "%s/bin/node" lge-node-home))
(setq lge-node-path (format "%s/lib/node_modules" lge-node-home))
(setq inferior-js-program-command (format "%s --interactive" lge-node-bin))
(setenv "NODE_NO_READLINE" "1")
(setenv "NODE_PATH" lge-node-path)

(when (>= emacs-major-version 24)
  (require-package 'js2-mode)
  (require-package 'ac-js2))
(require 'js)
(require 'js2-mode)

(defun lge-js-time-this-region (start end str)
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

(defun lge-js-toggle-js2-js-mode ()
  "Toggle between js2-mode and js-mode"
  (interactive)
  (if (string= major-mode "js-mode")
      (js2-mode)
    (js-mode)))

(defun lge-eval-node-js-on-region-or-buffer (start end)
  "If mark active, eval marked region; otherwise eval buffer. Display result in another buffer."
  (interactive "r")
  (if mark-active
      (progn
        (shell-command-on-region start end "node" "*js*")
        (display-buffer "*js*"))
    (progn
      (shell-command-on-region (point-min) (point-max) "node" "*js*")
      (display-buffer "*js*"))))

(defun lge-eval-node-js-on-region-and-replace (start end)
  "If mark active, eval marked region; otherwise eval buffer. Standard output result will replace the region or entire buffer."
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
           "^var +\\(.*\\) += +function *(\\([^)]*\\))"
           "\\|"
           "^function +\\([^(]+\\) *(\\([^)]*\\))"
           "\\)"
           ))
    (setq matches (s-match-strings-all pattern str))
    (setq res (mapcar
      (lambda (match)
        (if (>= (length match) 5)
            (cons (nth 3 match) (nth 4 match))
          (cons (nth 1 match) (nth 2 match))))
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

(defun lge-js-insert-outline-for-buffer ()
  "Grep all the functions, ClassName.method and ClassName.prototype.method,
insert to current position."
  (interactive)
  (when mark-active
    (delete-region (region-beginning) (region-end)))

  (let (buf-str fun-sigs insert-methods)
    (setq buf-str (buffer-substring-no-properties (point-min) (point-max)))
    (setq fun-sigs (lge-grep-functions buf-str))

    ;; Insert functions or classes
    (insert "// FUNCTIONS:\n")
    (mapc
     (lambda (f)
       (insert "//   " (car f) "(" (cdr f) ")" "\n"))
     fun-sigs)

    ;; Insert methods
    (mapc
     (lambda
       (fun-sig)
       (let (f sig ins-methods cls-methods)
         (setq f (car fun-sig))
         (setq sig (cdr fun-sig))
         (setq cls-methods (lge-grep-cls-methods buf-str f))
         (setq ins-methods (lge-grep-ins-methods buf-str f))

         (when (> (length ins-methods) 0)
           (insert "// //\n// [" f "] constructor:\n")
           (insert "//   " f "(" sig ")\n"))

         (when (> (length cls-methods) 0)
           (insert "// //\n// [" f "] class methods:\n")
           (lge-insert-methods f cls-methods "."))

         (when (> (length ins-methods) 0)
           (insert "// //\n// [" f "] instance methods:\n")
           (lge-insert-methods f ins-methods "::"))
         )
       ) fun-sigs)
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

;; js2-mode
(after-load 'js2-mode
  (add-hook 'js2-mode-hook '(lambda () (setq mode-name "JS2"))))

(setq js2-use-font-lock-faces t
      js2-mode-must-byte-compile nil
      js2-basic-offset 2
      js2-indent-on-enter-key t
      js2-auto-indent-p t
      js2-bounce-indent-p nil)

(after-load 'js2-mode (js2-imenu-extras-setup))

;; indent
(setq js-indent-level 2)
(setq javascript-indent-level 2)

(require-package 'js2-refactor)
(require 'js2-refactor)
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-m")

(defun lge-cycle-web-js-js2-mode ()
  (interactive)
  (cond
   ((string= major-mode "web-mode") (js-mode))
   ((string= major-mode "js-mode") (js2-mode))
   ((string= major-mode "js2-mode") (web-mode))
   (t (js2-mode))))

(require 'typescript)

(provide 'lge-js)
