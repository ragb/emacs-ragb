

;; Spell checking (requires the ispell software)
  (add-hook 'bibtex-mode-hook 'flyspell-mode)

  
;; Change fields and format
  (setq bibtex-user-optional-fields '(("keywords" "Keywords to describe the entry" "")
                                      ("file" "Link to document file." ":"))
        bibtex-align-at-equal-sign t)


;; BibLaTeX settings

(setq bibtex-dialect 'biblatex)


(use-package helm-bibtex :defer t
  :after org
  :config
  (setq bib-files-directory (directory-files
                             (concat org-directory "/documents/bibliography") t
                             "^[A-Z|a-z].+.bib$")
        pdf-files-directory (concat org-directory "/documents/pdf"))

    (require 'helm-config)
    (setq bibtex-completion-bibliography bib-files-directory
          bibtex-completion-library-path pdf-files-directory
          bibtex-completion-pdf-field "File"
          bibtex-completion-notes-path org-directory))


