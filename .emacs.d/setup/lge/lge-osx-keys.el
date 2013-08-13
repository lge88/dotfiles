(when *is-a-mac*
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'none)
  (setq default-input-method "MacOSX")
  (setq mouse-wheel-scroll-amount '(0.001))
  (when *is-cocoa-emacs*
    (global-set-key (kbd "M-`") 'ns-next-frame)))

(provide 'lge-osx-keys)
