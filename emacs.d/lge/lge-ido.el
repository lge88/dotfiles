;; Use C-f during file selection to switch to regular find-file
(require 'vc-git)

;; (ido-mode t)
;; (ido-everywhere t)
;; (setq ido-enable-flex-matching t)
;; (setq ido-use-filename-at-point nil)
;; (setq ido-auto-merge-work-directories-length 0)
;; (setq ido-use-virtual-buffers t)

;; (require-package 'ido-ubiquitous)
;; (ido-ubiquitous-mode t)

(require-package 'ido-vertical-mode)
(require 'ido-vertical-mode)
(ido-vertical-mode)

;;(require-package 'smex)
;;(global-set-key (kbd "M-x") 'smex)

;; (require-package 'idomenu)

;; Allow the same buffer to be open in different frames
;; (setq ido-default-buffer-method 'selected-window)

(provide 'lge-ido)
