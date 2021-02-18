
;; Add path to load-path
(setq load-path (cons "~/.emacs.d/lisp" load-path))


(load-library "emacspeak-prepare")

;; global variables
(setq
 inhibit-startup-screen t
 create-lockfiles nil
 make-backup-files nil
 column-number-mode t
 scroll-error-top-bottom t
 show-paren-delay 0.5
 use-package-always-ensure t
 use-package-always-defer t
 sentence-end-double-space nil
 dired-use-ls-dired nil)


;; buffer local variables
(setq-default
 indent-tabs-mode nil
 tab-width 4
 voice-lock-mode-set-explicitly t
 c-basic-offset 4)

;; modes
;;(electric-indent-mode 0)


;; global keybindings
(global-unset-key (kbd "C-z"))



;; Packages
(require 'package )
(setq
 package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
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
  :demand t
  :if (memq (window-system) '(mac ns))
  :init
    (exec-path-from-shell-initialize )
    (exec-path-from-shell-copy-envs '("LANG" "GPG_AGENT_INFO" "SSH_AUTH_SOCK"))
    )

;; ORG
(load-library "org-prepare")

(use-package grab-mac-link)

(load-library "helm-prepare")


(load-library "rust-prepare")



;; Idris
(use-package idris-mode)


(load-library "company-prepare.el")
(load-library "scala-prepare.el")



;; Enable nice rendering of diagnostics like compile errors.
(use-package flycheck :ensure t :defer t :pin melpa
  :init (global-flycheck-mode))

(load-library "lsp-prepare.el")
(load-library "kotlin-prepare.el")



(use-package yasnippet
  :diminish yas-global-mode
  :config (yas-reload-all))
(use-package winner :ensure t
  :defer t)



;; ag
(use-package ag :ensure t)


;; Projectile
(load-library "projectile-prepare")

(load-library "magit-prepare")
(load-library "markdown-prepare")
(load-library "smartparens-prepare")





(use-package intero :ensure t
  :config
  (add-hook 'haskell-mode-hook 'intero-mode))


;; Mastodon
(use-package mastodon
  :init
  (setq mastodon-instance-url "https://functional.cafe"))


;; Purescript
(use-package purescript-mode
  :mode "\\.purs$")
  
(use-package psc-ide
  :commands (psc-ide-mode turn-on-purescript-indent)
  :init(add-hook 'purescript-mode-hook #'(lambda()
                                          (progn
                                            (psc-ide-mode)
                                            (company-mode)
                                            (flycheck-mode)
                                            (turn-on-purescript-indent)))))
                                            

;; epubs
(use-package nov
  :mode (("\\.epub$" . nov-mode)))

;; webpaste
(load-library "webpaste-prepare.el")

;; protobuf
(load-library "protobuf-prepare.el"
)

;; Mac keyboard
(when (string-equal system-type "darwin")
  (setq default-input-method "MacOSX")
    (setq mac-option-key-is-meta nil)
    (setq mac-command-key-is-meta t)
    (setq mac-command-modifier 'meta)
    (setq mac-option-modifier nil))



;; alert
(use-package alert
  :config
  (when (string-equal system-type "darwin")
  (setq alert-default-style 'notifier)))



(add-hook 'emacs-lisp-mode-hook #'(lambda()
                        (company-mode)))


;; Unspell
(when   (executable-find "hunspell") 
  (setq-default ispell-program-name "hunspell") 
  (setq ispell-really-hunspell t))



;; save /reload desktop
(desktop-save-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("~/org/google.org" "~/org/tblx.org" "~/org/cs.org" "~/org/casa.org" "~/org/inbox.org" "~/org/dev.org" "~/org/projects.org" "~/org/music.org"))
 '(org-modules
   '(org-bbdb org-bibtex org-docview org-gnus org-habit org-id org-info org-irc org-mHe org-protocol org-rmail org-w3m org-git-link org-mac-iCal org-mac-link org-panel org-screenshot org-jira))
 '(package-selected-packages
   '(kotlin-mode ox-jira protobuf-mode excorporate org-roam lsp-metals org-journal-list treemacs-projectile confluence plantuml-mode yasnippet-classic-snippets github-review lsp-scala flycheck-rust cargo ammonite-term-repl ob-ammonite org-re-reveal ox-reveal htmlize sql-indent format-sql csv-mode company-lsp forge org-plus-contrib org-make-toc epresent presentation org-present magit-filenotify magit-popup groovy-mode company-irony irony nov purescript-mode psc-ide json-mode mastodon org-projectile org-index org-jira git-timemachine ctags-update etags-select popup-imenu goto-chg undo-tree yasnippet-snippets sound-wav org-pomodoro org-alert grabe-mac-link grab-mac-link speechd-el company-racer racer magit-gerrit org-projectile-helm intero jira-markup-mode slack jira git-link ag yaml-mode rust-mode helm-idris idris-mode helm phabricator flycheck-pony image-archive flx-isearch flx-search flx-ido use-package smartparens projectile markdown-mode magit exec-path-from-shell))
 '(safe-local-variable-values
   '((github-review-host . "git.daimler.com/api/v3")
     (voice-lock-mode . t)
     (folded-file . t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'upcase-region 'disabled nil)
