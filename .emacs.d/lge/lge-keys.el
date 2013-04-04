;; A minor mode to apply my own key bindings:
(cond
 
 ((string= system-name "Li-Ges-MacBook-Pro.local")
  (defvar real-keyboard-keys
    '(
      ;; TODO: set mac keyboard here
      )
    "An assoc list of pretty key strings and their terminal equivalents."
    )
  ;; (setq mac-command-modifier 'meta)
  )
 
 ((string= system-name "vision2.ucsd.edu")
  (message "welcome to vision lab!!!")
  (defvar real-keyboard-keys
    '(
      ("M-<up>"        . "O3A")
      ("M-<down>"      . "O3B")
      ("M-<right>"     . "O3C")
      ("M-<left>"      . "O3D")
      ("S-<down>"      . "O2B")
      ("S-<up>"        . "O2A")
      ("S-<left>"      . "O2D")
      ("S-<right>"     . "O2C")
      ("C-M-<down>"    . "O7B")
      ("C-M-<up>"      . "O7A")
      ("C-/"           . "")
      ("C-<return>"    . "\C-j")
      ("C-<delete>"    . "[3;5~")
      )
    "An assoc list of pretty key strings and their terminal equivalents."
    )
  )

 ;; ((string= system-name "localhost.localdomain")
 (t
  (message "welcome to HOME!!!")
  (defvar real-keyboard-keys
    '(
      ("M-<up>"        . "O3A")
      ("M-<down>"      . "O3B")
      ("M-<right>"     . "O3C")
      ("M-<left>"      . "O3D")
      ("S-<down>"      . "O2B")
      ("S-<up>"        . "O2A")
      ("S-<left>"      . "O2D")
      ("S-<right>"     . "O2C")
      ("C-M-<down>"    . "O7B")
      ("C-M-<up>"      . "O7A")
      ("C-/"           . "")
      ("C-<return>"    . "\C-j")
      ("C-<delete>"    . "[3;5~")
      )
    "An assoc list of pretty key strings and their terminal equivalents."
    )
  )
 )

(defun key (desc)
  (or (and window-system (read-kbd-macro desc))
      (or (cdr (assoc desc real-keyboard-keys))
          (read-kbd-macro desc))))
(defvar lge-keys-minor-mode-map (make-keymap) "lge-keys-minor-mode keymap.")

(defun add-lge-keys-minor-mode ()
  (interactive)

  (require 'magit)
  (require 'magit-svn)
  (define-key lge-keys-minor-mode-map (key "C-x g") 'magit-status)

  (require 'yasnippet)
  (define-key lge-keys-minor-mode-map (key "C-x y") 'yas-insert-snippet)
  (define-key lge-keys-minor-mode-map (key "C-x C-y") 'yas-describe-tables)
  
  (require 'undo-tree)
  (define-key lge-keys-minor-mode-map (key "C-c u") 'undo-tree-visualize)
  
  (define-key lge-keys-minor-mode-map (key "C-x x") 'eval-region)
  
  (eval-after-load "files"
    '(progn
       (define-key lge-keys-minor-mode-map (key "C-x s") 'save-buffer)
       ))
  
  (require 'simple)
  (define-key lge-keys-minor-mode-map (key "<f5>") 'toggle-truncate-lines)
  (define-key lge-keys-minor-mode-map (key "C-z") 'undo)
  (define-key lge-keys-minor-mode-map (key "M-D") 'backward-kill-word)

  (defun open-gnome-terminal-here ()
    "open ternimal and go to current directory"
    (interactive)
    (shell-command "gnome-terminal" nil nil)
    )
  (define-key lge-keys-minor-mode-map (key "<f8>") 'open-gnome-terminal-here)

  (defun open-file-browser-here ()
    "DOCSTRING"
    (interactive)
    (if (string= system-type "gnu/linux")
        (shell-command "gnome-open ." nil nil)
      (shell-command "open ." nil nil)))

  (define-key lge-keys-minor-mode-map (key "<f9>") 'open-file-browser-here)

  (require 'sgml-mode)
  (require 'lisp-mode)
  (require 'js2-mode)  
  (require 'js)
  (define-key js2-mode-map (key "<return>") 'newline-and-indent)
  (define-key js-mode-map (key "<return>") 'newline-and-indent)

  (define-key emacs-lisp-mode-map (key "<return>") 'newline-and-indent)
  (define-key sgml-mode-map (key "<return>") 'newline-and-indent)
  
  (require 'cua-base)
  (define-key lge-keys-minor-mode-map (key "<f7>") 'cua-mode)

  (define-key lge-keys-minor-mode-map (key "C-<tab>") 'other-window)

  (require 'sr-speedbar)
  ;; Use f12 to goto speedbar no matter what unless current window is speedbar it close it
  (define-key lge-keys-minor-mode-map (key "<f12>") 'go-to-speedbar-no-matter-what)
  (defun go-to-speedbar-no-matter-what()
    "DOCSTRING"
    (interactive)
    (if (string= (buffer-name) "*SPEEDBAR*")
        (sr-speedbar-toggle)
      (if (sr-speedbar-exist-p)
          (sr-speedbar-select-window)
        (progn
          (sr-speedbar-open)))))
  
  
  (eval-after-load "window"
    '(progn
       (define-key lge-keys-minor-mode-map (key "C-x l") 'recenter-top-bottom)
       ))

  ;; (eval-after-load "paragraphs"
  ;;   '(progn
  ;;      (define-key lge-keys-minor-mode-map (key "M-n") 'forward-paragraph)
  ;;      (define-key lge-keys-minor-mode-map (key "M-p") 'backward-paragraph)
  ;;      ))

  (require 'windmove)
  (define-key lge-keys-minor-mode-map (key "C-c <left>") 'windmove-left)
  (define-key lge-keys-minor-mode-map (key "C-c <right>") 'windmove-right)
  (define-key lge-keys-minor-mode-map (key "C-c <up>") 'windmove-up)
  (define-key lge-keys-minor-mode-map (key "C-c <down>") 'windmove-down)
  
  (require 'winner)
  (define-key lge-keys-minor-mode-map (key "C-x <left>") 'winner-undo)
  (define-key lge-keys-minor-mode-map (key "C-x <right>") 'winner-redo)
  (define-key lge-keys-minor-mode-map (key "C-x u") 'winner-undo)
  (define-key lge-keys-minor-mode-map (key "C-x U") 'winner-redo)
  
  (define-key lge-keys-minor-mode-map (key "<f10>") 'previous-buffer)
  (define-key lge-keys-minor-mode-map (key "<f11>") 'next-buffer)
  (require 'windswap)
  (define-key lge-keys-minor-mode-map (key "C-x w v") `window-horizontal-to-vertical)
  (define-key lge-keys-minor-mode-map (key "C-x w h") `window-vertical-to-horizontal)

  (require 'lined)
  (define-key lge-keys-minor-mode-map (key "C-k") 'kill-line)
  (define-key lge-keys-minor-mode-map (key "C-S-d") 'kill-whole-line-or-region)
  (define-key lge-keys-minor-mode-map (key "<S-return>") 'jump-to-newline)
  (define-key lge-keys-minor-mode-map (key "M-r") 'toggle-comment-line-or-region)
  (define-key lge-keys-minor-mode-map (key "C-M-<down>") 'duplicate-current-line-or-region)
  (define-key lge-keys-minor-mode-map (key "C-M-<up>") 'duplicate-current-line-or-region)
  (define-key lge-keys-minor-mode-map (key "M-<up>") 'move-text-up)
  (define-key lge-keys-minor-mode-map (key "M-<down>") 'move-text-down)
  (define-key lge-keys-minor-mode-map (key "C-l") 'expand-region-as-lines)

  (require 'nlinum)
  (define-key lge-keys-minor-mode-map (key "<f6>") 'nlinum-mode)

  (require 'menu-bar)
  (menu-bar-mode 1)
  
  (define-key lge-keys-minor-mode-map (key "C-c f") 'find-file-at-point)

  (require 'ibuffer)
  (global-set-key (key  "C-x C-b") 'ibuffer)
  

  ;; TODO:
  (require 'sh-script)
  (define-key sh-mode-map (key "C-M-x") 'sh-eval-current-line)
  (defun sh-eval-current-line ()
    "DOCSTRING"
    (interactive)
    (if mark-active 
        (sh-execute-region (mark) (point))
      (sh-execute-region (point-at-bol) (point-at-eol))
      )
    )

  (require 'ediff)
  (setq ediff-split-window-function 'split-window-horizontally)
  (global-set-key (key "C-x =") 'ediff-current-file)

  (defun dired-ediff-marked-two-files ()
    "compare two marked files with ediff"
    (interactive)
    (if (and (string= major-mode "dired-mode") (= (length (dired-get-marked-files)) 2))
        (let (fileA fileB)
          (setq fileA (nth 0 (dired-get-marked-files)))
          (setq fileB (nth 1 (dired-get-marked-files)))
          (ediff fileA fileB)
          )
      (message "please mark exactly two files")
      )
    )
  (define-key dired-mode-map (key "=") 'dired-ediff-marked-two-files)

  ;; mark word features:
  (defun my-mark-word (N)
    (interactive "p")
    (if (and 
         (not (eq last-command this-command))
         (not (eq last-command 'my-mark-word-backward)))
        (set-mark (point)))
    (forward-word N))

  (defun my-mark-word-backward (N)
    (interactive "p")
    (if (and
         (not (eq last-command this-command))
         (not (eq last-command 'my-mark-word)))
        (set-mark (point)))
    (backward-word N))
  
  ;; (define-key lge-keys-minor-mode-map (kbd "M-k") 'my-mark-word)
  ;; (define-key lge-keys-minor-mode-map (kbd "s-k") 'my-mark-word)
  ;; (define-key lge-keys-minor-mode-map (kbd "M-j") 'my-mark-word-backward)
  ;; (define-key lge-keys-minor-mode-map (kbd "s-j") 'my-mark-word-backward)

  (defun toggle-fullscreen (&optional f)
    (interactive)
    (let ((current-value (frame-parameter nil 'fullscreen)))
      (set-frame-parameter nil 'fullscreen
                           (if (equal 'fullboth current-value)
                               (if (boundp 'old-fullscreen) old-fullscreen nil)
                             (progn (setq old-fullscreen current-value)
                                    'fullboth)))))

  ;; Shortcuts
  (defalias 'nf 'new-frame)
  
  (defun lge-ls ()
    "list current directory in dired"
    (interactive)
    (dired default-directory))
  
  (defalias 'ls 'lge-ls)
  (defalias 'b 'ibuffer)
  (defalias 'lr 'list-registers)
  (defalias 'rj 'jump-to-register)
  (defalias 'rl 'bookmark-bmenu-list)

  (defun lge-goto-scatch ()
    "DOCSTRING"
    (interactive)
    (switch-to-buffer "*scratch*"))
  (defalias 'gs 'lge-goto-scatch)
  
  (defun lge-goto-scratch-and-paste ()
    "go to scratch buffer"
    (interactive)
    (if mark-active
        (progn
          (kill-ring-save (point) (mark))
          (switch-to-buffer "*scratch*")
          (end-of-buffer)
          (newline)
          (yank))
      (switch-to-buffer "*scratch*")))
  (defalias 'gsp 'lge-goto-scratch-and-paste)
  

  (define-minor-mode lge-keys-minor-mode
    "A minor mode to apply my key maps"
    t " lge" 'lge-keys-minor-mode-map)
  
  (defun my-minibuffer-setup-hook ()
    (lge-keys-minor-mode 0))
  
  (add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook))

(provide 'lge-keys)
