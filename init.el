;; Emacspeak stup
;; Change paths. This is for OSX.
;; emacspeak here is from svn, with the mac tts server from
;; https://code.google.com/p/e-mac-speak/
(when (string-equal system-type "darwin")
  (setq ns-pop-up-frames nil)
	(setq load-path (cons "~/src/emacspeak/lisp" load-path))
	(setq emacspeak-directory "~/src/emacspeak")
	(setq dtk-program "espeak")
	(load-file "~/src/emacspeak/lisp/emacspeak-setup.el")
	(load-file "~/src/emacspeak/lisp/mac-voices.el")
	(setq mac-default-speech-rate 480)
	(mac-define-voice 'joana " [{voice joana}] "))


(emacspeak-toggle-auditory-icons t)
(emacspeak-sounds-select-theme "classic/")
(setq tts-default-speech-rate 90)
(setq espeak-default-speech-rate 400)
(setq emacspeak-tts-use-notify-stream  t)

(setq emacspeak-eldoc-speak-explicitly nil)
(emacspeak-tts-startup-hook)

;; global variables
(setq
 inhibit-startup-screen t
 create-lockfiles nil
 make-backup-files nil
 column-number-mode t
 scroll-error-top-bottom t
 show-paren-delay 0.5
 use-package-always-ensure t
 sentence-end-double-space nil)



;; buffer local variables
(setq-default
 indent-tabs-mode nil
 tab-width 4
 c-basic-offset 4)

;; modes
;;(electric-indent-mode 0)


;; global keybindings
(global-unset-key (kbd "C-z"))



;; Packages
(require 'package )
(setq
 package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                    ("org" . "http://orgmode.org/elpa/")
                    ("melpa" . "http://melpa.org/packages/")
                    ("melpa-stable" . "http://stable.melpa.org/packages/")
))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))



;; Initialize path from shell.
(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns))
  :config ( exec-path-from-shell-initialize ))



;; org
(use-package org :ensure t
  :config
                 (setq org-log-done 'time)
             (setq org-directory "~/org/")
             ;(setq org-mobile-use-encryption t)
             (setq org-mobile-encryption-password "OrleansGodiva")
             (setq org-mobile-index-file "index.org")
    (setq org-mobile-directory "~/Dropbox/Aplicativos/MobileOrg")
    (setq org-mobile-inbox-for-pull "~/org/inbox.org")
    (setq org-mobile-files '("~/org/dev.org"))
    (setq org-clock-idle-time 10)
    (setq org-default-notes-file (concat org-directory "notes.org"))
    (setq org-refile-targets '((nil :maxlevel . 9)
                                (org-agenda-files :maxlevel . 9)))
(setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(setq org-refile-use-outline-path t)                  ; Show full paths for refiling

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (concat org-directory "todos.org") "Tasks")
             "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree (concat org-directory "journal.org"))
             "* %? %^g\nEntered on %U\n  %i\n  %a")))

                 (global-set-key "\C-cl" 'org-store-link)
             (global-set-key "\C-cc" 'org-capture)
             (global-set-key "\C-ca" 'org-agenda)
             (global-set-key "\C-cb" 'org-iswitchb)
    )




;; helm
(use-package helm
  :ensure t
  :config (require 'helm-config)
  (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)
(when (executable-find "curl") (setq helm-google-suggest-use-curl-p t)))

;; rust
(use-package rust-mode)

;; Idris
(use-package idris-mode)

;; Company
(use-package company
  :diminish company-mode
  :commands company-mode
  :init
  (setq
   company-dabbrev-ignore-case nil
   company-dabbrev-code-ignore-case nil
   company-dabbrev-downcase nil
   company-idle-delay 0
   company-minimum-prefix-length 4))

(use-package ensime :ensure t :pin melpa
  :init (setq ensime-use-helm nil) (setq ensime-eldoc-hints 'all))
(use-package sbt-mode :ensure t :pin melpa)
(use-package scala-mode :ensure t :pin melpa)

(use-package yasnippet
  :diminish yas-global-mode
  :config (yas-reload-all))
(use-package winner :ensure t
  :defer t)



;; ag
(use-package ag :ensure t)


;; Projectile
(use-package projectile
  :ensure t
  :demand
  :init   (setq projectile-use-git-grep t)
  :config (projectile-global-mode t)
  :bind   (("s-f" . projectile-find-file)
           ("s-F" . projectile-grep)))



;; magit
(use-package magit
  :ensure t
  :commands magit-status global-magit-file-mode
  :init (setq
         magit-revert-buffers nil)
       (global-magit-file-mode)
       :bind (("C-x g" . magit-status)))

(use-package git-link :ensure t)


;;(use-package phabricator)


;; Markdown
(use-package markdown-mode :ensure t
  :config (setq markdown-command "pandoc"))

;; parentesis
(use-package smartparens
  :diminish smartparens-mode
  :commands
  smartparens-strict-mode
  smartparens-mode
  sp-restrict-to-pairs-interactive
  sp-local-pair
  :init
  (setq sp-interactive-dwim t)
  :config
  (require 'smartparens-config)
  (sp-use-smartparens-bindings)

  (sp-pair "(" ")" :wrap "C-(") ;; how do people live without this?
  (sp-pair "[" "]" :wrap "s-[") ;; C-[ sends ESC
  (sp-pair "{" "}" :wrap "C-{")

  ;; WORKAROUND https://github.com/Fuco1/smartparens/issues/543
  (bind-key "C-<left>" nil smartparens-mode-map)
  (bind-key "C-<right>" nil smartparens-mode-map)

  (bind-key "s-<delete>" 'sp-kill-sexp smartparens-mode-map)
  (bind-key "s-<backspace>" 'sp-backward-kill-sexp smartparens-mode-map)
  (sp-local-pair 'scala-mode "(" nil :post-handlers '(("||\n[i]" "RET")))
(sp-local-pair 'scala-mode "{" nil :post-handlers '(("||\n[i]" "RET") ("| " "SPC"))))

;; Mac keyboard
(when (string-equal system-type "darwin")
  (setq default-input-method "MacOSX")
    (setq mac-option-key-is-meta nil)
    (setq mac-command-key-is-meta t)
    (setq mac-command-modifier 'meta)
    (setq mac-option-modifier nil))



(add-hook 'scala-mode-hook
          (lambda ()
            (show-paren-mode)
            (smartparens-mode)
            (yas-minor-mode)
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)
            (company-mode)
            (ensime-mode)
            (scala-mode:goto-start-of-code)
            (voice-lock-mode nil)))





;; save /reload desktop
(desktop-save-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/org/todos.org" "~/org/dev.org")))
 '(package-selected-packages
   (quote
    (jira-markup-mode slack jira git-link org-jira ag yaml-mode rust-mode helm-idris idris-mode helm phabricator flycheck-pony image-archive flx-isearch flx-search flx-ido use-package smartparens projectile markdown-mode magit exec-path-from-shell ensime))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
