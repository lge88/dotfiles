(provide 'lge-register)

(require 'register)
(set-register ?a `(file . "~/Develop/js/ifea/"))
(set-register ?b `(file . "~/.bashrc"))
(set-register ?c `(file . "~/dotfiles/"))
(set-register ?d `(file . "~/Develop/"))
(set-register ?e `(file . "~/.emacs.d/setup/lge/"))
(set-register ?i `(file . "~/.emacs.d/init.el"))
(set-register ?j `(file . "~/Develop/js/"))
(set-register ?h `(file . "~/"))
(set-register ?s `(file . "~/.emacs.d/snippets/"))
(set-register ?t `(file . "~/Dropbox/toolbox/"))
(set-register ?o `(file . "~/Dropbox/org/"))
(switch-to-buffer "*scratch*")
(point-to-register ?\s)
