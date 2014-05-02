(require 'sh-script)

(add-hook 'sh-mode-hook
          (lambda ()
            (setq sh-basic-offset 2)
            (setq sh-indentation 2)
            ))


(provide 'lge-sh)
