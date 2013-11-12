
(require 'org)

(setq org-directory "~/Dropbox/org")
(setq org-default-notes-file
      (concat org-directory "/notes.org"))

(setq org-agenda-files (file-expand-wildcards (concat org-directory "/*.org")))


(setq org-todo-keywords
      '((sequence "TODO(t)" "FIXME(f)" "ACTIVE(a)" "|" "DONE(d!)")))

(setq org-capture-templates
      '(("t" "TODO"
         entry
         (file+headline (concat org-directory "/gtd.org") "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("f" "FIXME"
         entry
         (file+headline (concat org-directory "/gtd.org") "Bugs")
         "* FIXME :%?:\n  In %F\n  %a")
        ("i" "Idea"
         entry
         (file (concat org-directory "/ideas.org"))
         "* %?")
        ("j" "Journal"
         entry
         (file+datetree (concat org-directory "/journal.org"))
         "* %?\nEntered on %U\n  %i\n  %a")))

(setq org-agenda-custom-commands
      '(("Q" . "Custom queries")
        ("Qa" "Archive search" search ""
         ((org-agenda-files (file-expand-wildcards (concat org-directory "/*.org_archive")))))
        ("QA" "Archive tags search" org-tags-view ""
         ((org-agenda-files (file-expand-wildcards (concat org-directory "/*.org_archive")))))
         ))


(provide 'lge-org)
