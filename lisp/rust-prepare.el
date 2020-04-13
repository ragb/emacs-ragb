;; rust
(use-package rust-mode)

(use-package racer
  :init (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode)
            (require 'rust-mode)
            (define-key rust-mode-map (kbd "\t") #'company-indent-or-complete-common)
            (setq company-tooltip-align-annotations t)
            )
