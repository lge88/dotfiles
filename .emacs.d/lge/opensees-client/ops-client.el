;; My opensees websocket client

(require 'websocket)
(eval-when-compile (require 'cl))
(setq websocket-debug t)
(defvar ops-client)

(defun ops-client-open ()
  "Open the opensess client, currently only one opensees client allow"
  (interactive)
  (setq ops-client
        (websocket-open
         "ws://127.0.0.1:7681"
         :protocol "ops-protocol"
         :on-open (lambda (websocket) 
                    (ops-client-pop-to-debug)
                    )
         :on-message (lambda (websocket frame)
                       (ops-client-pop-to-debug)
                       )
         :on-close (lambda (websocket) 
                     (message "ops-client closed")
                     ))
        )
  )

(defun ops-client-pop-to-debug ()
  "Open websocket log buffer. Not used in testing. Just for debugging."
  (interactive)
  (display-buffer (websocket-get-debug-buffer-create ops-client)))

(defun ops-client-close ()
  "close the opensees client"
  (interactive)
  (websocket-close ops-client)
  )

(defun ops-client-isopen ()
  "Is the opensees client opened"
  (interactive)
  (if (websocket-openp ops-client)
      (message "yes")
    (message "no")
    )
  )

(defun ops-client-send-buffer ()
  "send current buffer to opensees server"
  (interactive)
  (websocket-send-text ops-client (buffer-string))
  )

(defun ops-client-send-line ()
  "send current line to opensees server"
  (interactive)
  (websocket-send-text ops-client (buffer-substring (point-at-bol) (point-at-eol)))
  )

(defun ops-client-send-region ()
  "DOCSTRING"
  (interactive)
  (if mark-active
      (websocket-send-text ops-client (buffer-substring (region-beginning) (region-end)))
    (message "no selected region")
    )
  )

;; (defun ops-client-pop-to-debug ()
;;   "Open websocket log buffer. Not used in testing. Just for debugging."
;;   (interactive)
;;   (display-buffer (websocket-get-debug-buffer-create ops-client)))

;; (defun ops-client-pop-to-debug (ops-client)
;;   "Open websocket log buffer. Not used in testing. Just for debugging."
;;   (interactive)
;;   (display-buffer (websocket-get-debug-buffer-create ops-client)))

(defvar ops-client-minor-mode-map (make-keymap) "opensees client key map")

(define-key ops-client-minor-mode-map (key "C-c C-o") 'ops-client-open)
(define-key ops-client-minor-mode-map (key "C-c C-c") 'ops-client-close)
(define-key ops-client-minor-mode-map (key "C-c ?") 'ops-client-isopen)
(define-key ops-client-minor-mode-map (key "C-c C-p") 'ops-client-pop-to-debug)
(define-key ops-client-minor-mode-map (key "C-c C-l") 'ops-client-send-line)
(define-key ops-client-minor-mode-map (key "C-c C-r") 'ops-client-send-region)
(define-key ops-client-minor-mode-map (key "C-c C-s") 'ops-client-send-buffer)

(define-minor-mode ops-client-minor-mode
  "A minor mode to apply my key maps"
  nil " ops-client" 'ops-client-minor-mode-map)

(provide 'ops-client)
