
;; Packages
( require 'package ) ( add-to-list 'package-archives ' ( "marmalade" . "http://marmalade-repo.org/packages/" )) ( package-initialize ) 

(defvar my-packages '(
		      ;; Clojure
cider clojure-mode clojure-test-mode
;; Python
python-mode
;; Scala
scala-mode
;; Golang
go-mode
;; LaTeX
auctex
;; Utilities
dropbox evernote-mode
;; Git
git-commit-mode
))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))



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
(emacspeak-sounds-select-theme "chimes-stereo/")
(emacspeak-tts-startup-hook)


;; Python
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '( "\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '( "python" . python-mode)) 

;; Fix shell path on OSX
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(if window-system (set-exec-path-from-shell-PATH))
