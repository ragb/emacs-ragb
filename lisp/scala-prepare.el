;; Enable scala-mode and sbt-mode
(use-package scala-mode :ensure t :defer t :pin melpa
  :mode "\\.s\\(cala\\|bt\\)$"
  :bind (:map scala-mode-map ("C-c C-B c" . sbt-command))
  )

(use-package sbt-mode :ensure t :defer t :pin melpa
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
   (setq sbt:program-options '("-Dsbt.supershell=false"))
)


(use-package ammonite-term-repl)


(add-hook 'scala-mode-hook
          (lambda ()
            (show-paren-mode)
            (smartparens-mode)
            (yas-minor-mode)
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)
(company-mode)
(define-key scala-mode-map (kbd "<tab>") #'company-indent-or-complete-common)
            (scala-mode:goto-start-of-code)
            (voice-lock-mode nil)))
