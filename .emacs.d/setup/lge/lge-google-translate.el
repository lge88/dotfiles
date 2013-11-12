
;;; FIXME: doesn't work
;;; google-translate-read-target-language: Invalid function: (read-language nil (google-translate-completing-read prompt (google-translate-supported-languages)))

(require-package 'google-translate)
(require 'google-translate)
(global-set-key "\C-ct" 'google-translate-at-point)
(global-set-key "\C-cT" 'google-translate-query-translate)

(provide 'lge-google-translate)
