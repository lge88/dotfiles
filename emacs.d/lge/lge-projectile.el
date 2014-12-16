
(require-package 'projectile)
(require 'projectile)

(projectile-global-mode t)
(setq projectile-enable-caching t)
(setq projectile-switch-project-action 'projectile-dired)

(require-package 'helm-projectile)
(require 'helm-projectile)
(helm-projectile-on)

(provide 'lge-projectile)
