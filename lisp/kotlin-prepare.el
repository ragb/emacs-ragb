(use-package kotlin-mode :ensure t)


(use-package lsp-kotlin :ensure t
  :init (setq lsp-kotlin-language-server-path "~/src/kotlin-language-server/server/build/install/server/bin/kotlin-language-server")
  :hook (kotlin-mode . lsp-kotlin-enable)
)


