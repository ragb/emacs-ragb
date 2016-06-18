;; Emacspeak stup
;; Change paths. This is for OSX.
;; emacspeak here is from svn, with the mac tts server from
;; https://code.google.com/p/e-mac-speak/
(when (string-equal system-type "darwin")
	(setq load-path (cons "~/src/emacspeak/lisp" load-path))
	(setq emacspeak-directory "~/src/emacspeak")
	(setq dtk-program "mac")
	(load-file "~/src/emacspeak/lisp/emacspeak-setup.el")
	(load-file "~/src/emacspeak/lisp/mac-voices.el")
	(setq mac-default-speech-rate 480))


(emacspeak-toggle-auditory-icons t)
(emacspeak-sounds-select-theme "classic/")
(setq tts-default-speech-rate 90)
(setq espeak-default-speech-rate 400)
(emacspeak-tts-startup-hook)



;; Packages
(require 'package )
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(defvar my-packages '(
;; Utilities
use-package
		      ;; Clojure
cider clojure-mode
;; haskell
haskell-mode
;; lisps and so on (works well with emacspeak)
paredit
;; Python
python-mode jedi
;; Scala
ensime
;; Golang
go-mode
company-go
;; Web development
js2-mode web-beautify
;; LaTeX
auctex
;; Markdown Editing
markdown-mode
;; Utilities
dropbox
;; Git
magit
;; fix itpath
exec-path-from-shell
;; projects
projectile
;; oarentesis
smartparens
))

(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Initialize path from shell.
( when ( memq window-system ' ( mac ns )) ( exec-path-from-shell-initialize )) 


;; no startup msg  
(setq inhibit-startup-message t)        ; Disable startup message 

;; Python
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '( "\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '( "python" . python-mode)) 
( add-hook 'python-mode-hook 'jedi:setup ) ( setq jedi:setup-keys t ) ; optional ( setq jedi:complete-on-dot t ) ; optional 


;; Projectile
(use-package projectile
  :demand
  :init   (setq projectile-use-git-grep t)
  :config (projectile-global-mode t)
  :bind   (("s-f" . projectile-find-file)
           ("s-F" . projectile-grep)))



;; Cider configuration (clojure)
;(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode ) 
(setq cider-repl-result-prefix ";; => " ) 
( setq cider-prompt-save-file-on-load nil ) 
( add-hook 'cider-repl-mode-hook 'paredit-mode )
(require 'company)
( setq nrepl-hide-special-buffers t ) 
( setq cider-repl-pop-to-buffer-on-connect nil ) 
( setq cider-auto-select-error-buffer t ) 
( setq cider-repl-popup-stacktraces t ) 
( add-hook 'cider-repl-mode-hook 'subword-mode ) 

(use-package ensime
  :commands ensime ensime-mode)

(add-hook 'scala-mode-hook 'ensime-mode)

;; Javascript
( add-hook 'js-mode-hook 'js2-minor-mode)


;; go
(require 'company)                                   ; load company mode
(require 'company-go)                                ; load company mode go backend
(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))

(add-hook 'before-save-hook 'gofmt-before-save ) 

;; LaTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)


;; Org
     (global-set-key "\C-cl" 'org-store-link)
     (global-set-key "\C-ca" 'org-agenda)
     (global-set-key "\C-cc" 'org-capture)
     (global-set-key "\C-cb" 'org-iswitchb)

;; magit
(use-package magit
  :commands magit-status global-magit-file-mode
  :init (setq
         magit-revert-buffers nil)
       (global-magit-file-mode)
  :bind (("C-x g" . magit-status)))

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
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'none))


;; save /reload desktop
(desktop-save-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(markdown-command "pandoc")
 '(package-selected-packages
   (quote
    (ws-butler web-beautify simple-httpd scala-mode python-mode paredit markdown-mode magit js2-mode jedi helm-gtags go-autocomplete git-rebase-mode git-commit-mode ggtags function-args flycheck exec-path-from-shell evernote-mode ensime dtrt-indent dropbox company-go company-ghc company-auctex clojure-test-mode clean-aindent-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
