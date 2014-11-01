(require 'ispell)
(when *is-a-mac*
(setq ispell-program-name "/usr/local/Cellar/aspell/0.60.6.1/bin/aspell"))
(provide 'lge-ispell)
