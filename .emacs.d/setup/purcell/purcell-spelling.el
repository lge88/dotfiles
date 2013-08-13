(require 'ispell)

(when (executable-find ispell-program-name)
  (require 'purcell-flyspell))

(provide 'purcell-spelling)
