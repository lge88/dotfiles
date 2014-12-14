
(require-package 'helm)
(require 'helm)

(setq helm-truncate-lines t)
(setq helm-buffers-favorite-modes
      '(text-mode
        js-mode
        emacs-lisp-mode
        python-mode
        markdown-mode
        ))

(require 'helm-elisp-package)
(defun lge-helm-list-elisp-packages (arg)
  (interactive "P")
  (when arg (setq helm-el-package--initialized-p nil))
  (helm :sources 'helm-source-list-el-package
        :buffer "*helm list packages*"
        :truncate-lines t))

(require 'helm-buffers)
(require 'helm-files)
(defun lge-helm-buffers-list ()
  "Preconfigured `helm' to list buffers."
  (interactive)
  (helm :sources '(helm-source-buffers-list
                   helm-source-ido-virtual-buffers
                   ;helm-source-recentf
                   helm-source-buffer-not-found)
        :buffer "*helm buffers*"
        :keymap helm-buffer-map
        :truncate-lines t))

(require 'helm-net)
(defun lge-helm-search-web ()
  (interactive)
  (helm :sources '(helm-source-google-suggest
                   helm-source-wikipedia-suggest
                   )
        :buffer "*helm web search*"
        :truncate-lines t))

(require 'helm-sys)
(defun lge-helm-top ()
  "Preconfigured `helm' for top command."
  (interactive)
  (save-window-excursion
    (unless helm-alive-p (delete-other-windows))
    (helm :sources 'helm-source-top
          :buffer "*helm top*" :full-frame t
          :candidate-number-limit 9999
          :truncate-lines t)))

(provide 'lge-helm)
