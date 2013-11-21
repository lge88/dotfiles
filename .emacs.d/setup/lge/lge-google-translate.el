
;;; FIXME: doesn't work
;;; google-translate-read-target-language: Invalid function: (read-language nil (google-translate-completing-read prompt (google-translate-supported-languages)))

(require-package 'google-translate)
(require 'google-translate)

(setq google-translate-default-source-language "en")
(setq google-translate-default-target-language "zh-CN")

(provide 'lge-google-translate)
