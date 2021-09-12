50
(use-package lsp-mode :ensure t :defer t :pin melpa
  :config (setq lsp-prefer-flymake nil)
  :hook (scala-mode . lsp)
  (java-mode . lsp)
  (lsp-mode . lsp-lens-mode)
  )


(use-package lsp-ui :ensure t :defer t :pin melpa)


  



;; Use the Debug Adapter Protocol for running tests and debugging
(use-package posframe :ensure t :pin melpa
  ;; Posframe is a pop-up tool that must be manually installed for dap-mode
  )

(use-package dap-mode :ensure t :pin melpa
  :hook
  (lsp-mode . dap-mode)
  (lsp-mode . dap-ui-mode)
  )
