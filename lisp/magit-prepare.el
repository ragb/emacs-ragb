;; magit
(use-package magit
  :ensure t
  :commands magit-status magit-dispatch global-magit-file-mode
  :init (setq
         magit-revert-buffers nil)
       (global-magit-file-mode)
       :bind (("C-x g" . magit-status)))

(use-package treemacs-magit :ensure t)
(use-package git-link :ensure t)


(use-package forge
  :after magit
  :pin melpa
  :ensure t
  :config (add-to-list 'forge-alist '("git.daimler.com" "git.daimler.com/api/v3" "git.daimler.com" forge-github-repository)))

(use-package github-review :ensure t :defer t
  :after forge)
