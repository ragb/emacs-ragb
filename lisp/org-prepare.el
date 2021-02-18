(use-package org :ensure t :pin org
  :preface
      (defun org-journal-find-location ()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (org-journal-new-entry t)
  ;; Position point on the journal's top-level heading so that org-capture
  ;; will add the new entry as a child entry.
  (goto-char (point-min)))

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

                ("j" "Journal entry" entry (function org-journal-find-location)
                 "* %(format-time-string org-journal-time-format)%^{Title}\n%i%?")
      ("c" "Note on current task" item (clock))))

    :bind (("\C-cl" . org-store-link)
             ("\C-cc" . org-capture)
             ("\C-ca" . org-agenda)
             ("\C-c C-j" . org-clock-goto)
             ("\C-c C-p" . org-pomodoro)
             ("\C-cb" . org-switchb))
    )




;; org-jorunal
  (use-package org-journal
    :after org
    :pin melpa
    :preface
    (defun get-journal-file-yesterday ()
      "Gets filename for yesterday's journal entry."
      (let* ((yesterday (time-subtract (current-time) (days-to-time 1)))
             (daily-name (format-time-string "%Y%m%d" yesterday)))
        (expand-file-name (concat org-journal-dir daily-name))))

    (defun journal-file-yesterday ()
      "Creates and load a file based on yesterday's date."
      (interactive)
      (find-file (get-journal-file-yesterday)))
    :custom
    (org-journal-date-format "%e %b %Y (%A)")
    (org-journal-dir (format "~/org/journal/" (format-time-string "%Y")))

    (org-journal-file-format "%Y%m%d")
    (org-journal-time-format ""))


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


  
;; org-roam
(use-package org-roam
  :after org
  :hook (org-mode . org-roam-mode)
  :custom
  (org-roam-directory "~/org/roam/")
  (org-roam-index-file "index")
  :bind
  ("C-c n l" . org-roam)
  ("C-c n t" . org-roam-dailies-today)
  ("C-c n y" . org-roam-dailies-yesterday)
  ("C-c n f" . org-roam-find-file)
  ("C-c n i" . org-roam-insert)
  ("C-c n j" . org-roam-jump-to-index)
  ("C-c n g" . org-roam-show-graph))
