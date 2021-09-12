;; Emacspeak stup
;; Change paths. This is for OSX.
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
(emacspeak-sounds-select-theme "classic")
(setq tts-default-speech-rate 450)
(setq espeak-default-speech-rate 450)
(setq emacspeak-tts-use-notify-stream  t)
(setq emacspeak-play-program "afplay")

(setq emacspeak-eldoc-speak-explicitly nil)
(dtk-set-language "pt-pt")


 
