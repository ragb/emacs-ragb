 (use-package org

   :config

  (setq org-log-done 'time)
  (setq org-babel-load-languages '((amm . t) (haskell . t) (python . t) (scala . t)))
                 (setq org-directory "~/org/")
                 (setq org-agenda-include-diary t)
;                 (setq org-agenda-add-span "DAY")

    (setq org-clock-out-when-done t)
    (setq org-clock-idle-time 10)
    (setq org-clock-history-length 10)
    (setq org-clock-in-switch-to-state "STARTED")
    (setq org-default-notes-file (concat org-directory "notes.org"))
    (setq org-refile-targets '((nil :maxlevel . 9)
                                (org-agenda-files :maxlevel . 3)))
    (setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
    (setq org-refile-use-outline-path t)                  ; Show full paths for refiling
    (setq org-agenda-skip-deadline-if-done t)
    (setq org-agenda-skip-scheduled-if-deadline-is-shown t)
    (setq org-agenda-skip-scheduled-if-done t)
    (setq org-stuck-projects
          '("+project/-MAYBE-DONE" ("TODO" "NEXT" "NEXTACTION") nil ""))

    (setq org-global-properties
    '(("Effort_ALL". "0 0:10 0:30 1:00 2:00 3:00 4:00 8:00")))

(setq org-capture-templates
      '(
        ("t" "Todo")
        ("tt" "Todo-normal" entry (file "inbox.org")
         "* TODO %?\n  %U\n  %i")
        ("ts" "Todo-safari"nn entry (file "inbox.org")
         "* TODO %?\n  %U\n  %(org-mac-safari-get-frontmost-url)")
        ("n" "General notes")
        ("nc" "Note from clipboard contents" entry (file "inbox.org")
         "* %?\n- Stored on %U\n\n%x")

                ("nl" "Note from current position" entry (file "inbox.org")
         "* %?\n- Stored on %U\n\n  %i\n  %a")

      ("c" "Note on current task" item (clock))))
:bind
             ("\C-cc" . org-capture)
             ("\C-ca" . org-agenda)
             ("\C-c C-j" . org-clock-goto)
             ("\C-c C-p" . org-pomodoro)
             ("\C-cb" . org-switchb))
    





;; org-re-reveal (presentations)
(use-package org-re-reveal :ensure t)

(use-package org-alert
  :init (setq org-alert-interval 3600)
  :config(org-alert-enable))


(use-package org-pomodoro
  :config
    (setq org-pomodoro-keep-killed-pomodoro-time t)
    (setq org-pomodoro-ticking-frequency 60)
    (setq org-pomodoro-ask-upon-killing nil)
    (setq org-pomodoro-manual-break t)
    )




 
(use-package org-roam 

  :pin melpa
  :defer t
  :after org
  :config
  (defun my/initiate-org-roam-time-note ()
  (interactive)
  (let ((ts (read-from-minibuffer "Timestamp (YYYYmmdd-HHMMSS): "
                                  (ts-format "%Y%m%d-%H%M%S" (ts-now)))))
    (if (string-match (rx (repeat 8 digit)
                          "-"
                          (repeat 6 digit))
                      ts)
        (setq my/*time-note-last-time* ts)
      (error "Incorrect input format."))))

  (org-roam-db-autosync-mode)

(setq org-roam-capture-templates
      `(("p" "Permanent Note" plain "%?"
         :if-new (file+head "${slug}.org"
                            "#+title: ${title}\n")
         :unnarrowed t)

        ("f" "Fleeting Note" plain "%?"
         :if-new (file+head "fleeting/%<%Y%m%d-%H%M%S>.org"
                            "#+TITLE: %<%Y%m%d-%H%M%S>--${title}\n")
         :unnarrowed t)

        ("t" "Time Note" plain "%?"
         :if-new (file+head "fleeting/%(my/initiate-org-roam-time-note).org"
                            "#+TITLE: %(eval my/*time-note-last-time*)--${title}

[[tsl:%(eval my/*time-note-last-time*)]]

")
         :unnarrowed t)

        ("l" "Literature Note" plain "%?"
         :if-new (file+head "literature/${slug}.org"
                            "#+TITLE: ${title}
#+ROAM_KEY: ${ref}")
         :unnarrowed t)
        ))
(setq org-roam-capture-ref-templates
      '(("r" "ref" plain "%?"
         :if-new (file+head "literature/${slug}.org"
                            "#+title: ${title}
#+roam_key: ${ref}")
         :unnarrowed t)))

:custom
(org-roam-dailies-capture-templates
           '(("d" "default" entry
              "* %?"
              :target (file+head "%<%Y-%m-%d>.org"
                                 "#+title: %<%Y-%m-%d>\n"))))
  (org-roam-directory "~/org/roam/")
                                        ;  (org-roam-index-file "index")
  (org-roam-v2-ack t)

   :bind
   (
    ("\C-c n c" . org-roam-capture)
    ("\C-c n t" . org-roam-dailies-today)
  ("\C-c n y" . org-roam-dailies-yesterday)
  ("\C-c n f" . org-roam-node-find)

  (:map org-mode-map
        ("\C-c n i" . org-roam-node-insert)
        ("\C-c n a" . org-roam-alias-add)
        ("\C-c n l" . org-roam-buffer-toggle)
        ("\C-c n t" . org-roam-tag-add)
)

  )

  )





     (use-package org-download
       :after org
       :bind
       (:map org-mode-map
             (("s-Y" . org-download-screenshot)
              ("s-y" . org-download-yank))))

(use-package deft
    :config
    (setq deft-directory org-directory
          deft-recursive t
          deft-strip-summary-regexp ":PROPERTIES:\n\\(.+\n\\)+:END:\n"
          deft-use-filename-as-title t)
    :bind
    ("C-c n d" . deft))


(use-package org-ref
    :config
    (setq org-ref-completion-library 'org-ref-helm-cite
          org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
          org-ref-default-bibliography bib-files-directory
          org-ref-notes-directory org-directory
          org-ref-notes-function 'orb-edit-notes))


(use-package org-roam-bibtex
    :after (org-roam helm-bibtex org-ref)
    :bind (:map org-mode-map ("C-c n b" . orb-note-actions)))

