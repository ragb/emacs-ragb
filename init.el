;; Emacspeak stup
;; Change paths. This is for OSX.
;; emacspeak here is from svn, with the mac tts server from
;; https://code.google.com/p/e-mac-speak/
(when (string-equal system-type "darwin")
	(setq load-path (cons "~/Sources/emacspeak/lisp" load-path))
	(setq emacspeak-directory "~/Sources/emacspeak")
	(setq dtk-program "mac")
	(load-file "~/Sources/emacspeak/lisp/emacspeak-setup.el")
	(load-file "~/Sources/emacspeak/lisp/mac-voices.el")
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
		      ;; Clojure
cider clojure-mode
;; lisps and so on (works well with emacspeak)
paredit
;; Python
python-mode jedi
;; Scala
scala-mode2 ensime sbt-mode
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
;; auto completion
auto-complete ac-nrepl company
;; fix itpath
exec-path-from-shell
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

; Scala
;; This step causes the ensime-mode to be started whenever
;; scala-mode is started for a buffer. You may have to customize this step
;; if you're not using the standard scala mode.
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

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


;; Mac keyboard
(when (string-equal system-type "darwin")
  (setq default-input-method "MacOSX")
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'none))


;; save /reload desktop
(desktop-save-mode 1)
