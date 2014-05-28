
;; Packages
( require 'package )
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(defvar my-packages '(
		      ;; Clojure
cider clojure-mode clojure-test-mode
;; lisps and so on (works well with emacspeak)
paredit
;; Python
python-mode
;; Scala
scala-mode2 ensime
;; Golang
go-mode go-autocomplete
company-go
;; Web development
js2-mode web-beautify
;; LaTeX
auctex
;; Markdown Editing
markdown-mode
;; Utilities
dropbox evernote-mode
;; Git
git-commit-mode magit
;; auto completion
auto-complete ac-nrepl company
;; fix path
exec-path-from-shell
))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Initialize path from shell.
( when ( memq window-system ' ( mac ns )) ( exec-path-from-shell-initialize )) 


;; no startup msg  
(setq inhibit-startup-message t)        ; Disable startup message 

;; Emacspeak stup
;; Change paths. This is for OSX.
;; emacspeak here is from svn, with the mac tts server from
;; https://code.google.com/p/e-mac-speak/
(setq load-path (cons "~/Sources/emacspeak/lisp" load-path))
(setq emacspeak-directory "~/Sources/emacspeak")
(setq dtk-program "mac")
(load-file "~/Sources/emacspeak/lisp/mac-voices.el")

(setq mac-default-speech-rate 450)
(load-file "~/Sources/emacspeak/lisp/emacspeak-setup.el")

;(emacspeak-toggle-auditory-icons t)
;(emacspeak-sounds-select-theme "chimes-stereo/")
(emacspeak-tts-startup-hook)


;; Python
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '( "\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '( "python" . python-mode)) 


;; Cider configuration (clojure)
;(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode ) 
(setq cider-repl-result-prefix ";; => " ) 
( setq cider-prompt-save-file-on-load nil ) 
( add-hook 'cider-repl-mode-hook 'paredit-mode )
(require 'company)



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

;; Mac keyboard
(setq default-input-method "MacOSX")
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'none)


;; save /reload desktop
(desktop-save-mode 1)
