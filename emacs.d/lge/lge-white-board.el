
(defvar lge-white-board-mode-list
  (list 'font-lock-mode
        'yas/minor-mode
        'auto-complete-mode))

(defun lge-enter-white-board-mode ()
  "White board mode"
  (interactive)
  (mapcar (lambda (mode) (funcall (symbol-function mode) 0))
          lge-white-board-mode-list))

(defun lge-exit-white-board-mode ()
  "Get all the fancy stuff back"
  (interactive)
  (mapcar (lambda (mode) (funcall (symbol-function mode) 1))
          lge-white-board-mode-list))

(provide 'lge-white-board)
