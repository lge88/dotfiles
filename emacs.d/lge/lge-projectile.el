
(require-package 'projectile)
(require 'projectile)

(require-package 'helm-projectile)
(require 'helm-projectile)
(helm-projectile-on)

(projectile-global-mode t)
(setq projectile-enable-caching t)
(setq projectile-switch-project-action 'projectile-dired)

(provide 'lge-projectile)
