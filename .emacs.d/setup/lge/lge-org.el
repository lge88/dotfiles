
(require 'org)

(setq org-directory "~/Dropbox/org")
(setq org-default-notes-file
      (concat org-directory "/notes.org"))

(setq org-agenda-files (file-expand-wildcards (concat org-directory "/*.org")))


(setq org-todo-keywords
      '((sequence "TODO(t)" "FEATURE(F)" "FIXME(f)" "ACTIVE(a)" "|" "CANCELED(c)" "DONE(d!)")))

(setq org-capture-templates
      '(("t" "TODO"
         entry
         (file+headline (concat org-directory "/gtd.org") "Tasks")
         "* TODO %?\n %i")
        ("d" "DEADLINE"
         entry
         (file+headline (concat org-directory "/gtd.org") "Deadlines")
         "* TODO %?\n DEADLINE: %T")
        ("b" "FIXME"
         entry
         (file+headline (concat org-directory "/coding.org") "Bugs")
         "* FIXME %?\n %i\n %a")
        ("f" "FEATURE"
         entry
         (file+headline (concat org-directory "/coding.org") "Features")
         "* FEATURE %?")
        ("s" "SNIPPETS"
         entry
         (file (concat org-directory "/snippets.org"))
         "* %?\n #+BEGIN_SRC\n %i\n #+END_SRC\n")
        ("I" "IDEA"
         entry
         (file (concat org-directory "/ideas.org"))
         "* %?")
        ("j" "JOURNAL"
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
