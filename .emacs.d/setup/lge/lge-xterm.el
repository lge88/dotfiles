
(defvar after-make-console-frame-hooks '()
  "Hooks to run after creating a new TTY frame")
(defvar after-make-window-system-frame-hooks '()
  "Hooks to run after creating a new window-system frame")

(defun run-after-make-frame-hooks (frame)
  "Run configured hooks in response to the newly-created FRAME.
Selectively runs either `after-make-console-frame-hooks' or
`after-make-window-system-frame-hooks'"
  (with-selected-frame frame
    (run-hooks (if window-system
                   'after-make-window-system-frame-hooks
                 'after-make-console-frame-hooks))))

(add-hook 'after-make-frame-functions 'run-after-make-frame-hooks)

(defun fix-up-xterm-control-arrows ()
  (let ((map (if (boundp 'input-decode-map)
                 input-decode-map
               function-key-map)))
    (define-key map "\e[1;5A" [C-up])
    (define-key map "\e[1;5B" [C-down])
    (define-key map "\e[1;5C" [C-right])
    (define-key map "\e[1;5D" [C-left])
    (define-key map "\e[5A"   [C-up])
    (define-key map "\e[5B"   [C-down])
    (define-key map "\e[5C"   [C-right])
    (define-key map "\e[5D"   [C-left])

    (define-key map "O3A" [M-up])
    (define-key map "O3B" [M-down])
    (define-key map "O3C" [M-right])
    (define-key map "O3D" [M-left])
    (define-key map "O2B" [S-down])
    (define-key map "O2A" [S-up])
    (define-key map "O2D" [S-left])
    (define-key map "O2C" [S-right])
    (define-key map "O7B" [C-M-down])
    (define-key map "O7A" [C-M-up])
    (define-key map "" [C-/])
    (define-key map "\C-j" [C-<return>])
    (define-key map "[3;5~" [C-<delete>])
    ))

;; (add-hook 'after-make-console-frame-hooks
;;           (lambda ()
;;             (message "hey i ran!!")
;;             (when (< emacs-major-version 23)
;;               (fix-up-xterm-control-arrows))
;;             (xterm-mouse-mode 1)
;;             (when (fboundp 'mwheel-install)
;;               (mwheel-install))))

(progn
  (when (< emacs-major-version 23)
    (fix-up-xterm-control-arrows))
  (xterm-mouse-mode 1)
  (when (fboundp 'mwheel-install)
    (mwheel-install)))

(provide 'lge-xterm)
